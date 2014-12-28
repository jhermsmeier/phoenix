//
//  Lexer.m
//
//  Created by Gregory Casamento.
//

#import "Lexer.h"
#import "Regex.h"

static TokenData *lastyylexToken = nil;

@implementation TokenData

- (id)initWithToken:(TOKEN)token
              value:(NSString *)value
{
    self = [super init];
    if(self != nil)
    {
        self.token = token;
        self.value = value;
    }
    return self;
}

- (id) copyWithZone: (NSZone *)zone
{
    TokenData *data = [[TokenData alloc] initWithToken:self.token
                                                 value:self.value];
    return data;
}

@end

@implementation Lexer

- (id) initWithSourceCode: (NSString *)theCode
{
    self = [super init];
    if(self != nil)
    {
        code = [theCode copy];
        lastParsed = @"";
        consumed = 0;
        tokenStack = [[NSMutableArray alloc] initWithCapacity:500];
        debugYYLex = NO;
        
        // Regular expressions...
        cleanRegex = [[Regex alloc] initWithPattern: @"^[\\s\r\n]+"];
        identifierRegex = [[Regex alloc] initWithPattern: @"^[a-zA-Z_]+[\\w]*"];
        binaryNumberRegex = [[Regex alloc] initWithPattern: @"^0b[01]+"];
        octalNumberRegex = [[Regex alloc] initWithPattern: @"^0o[0-7]+"];
        hexNumberRegex = [[Regex alloc] initWithPattern: @"^0x[\\da-f]+"];
        decimalNumberRegex = [[Regex alloc] initWithPattern: @"^\\d+\\.?\\d*(?:e[+-]?\\d+)?"];
        booleanRegex = [[Regex alloc] initWithPattern: @"^true|^false"];
        stringRegex = [[Regex alloc] initWithPattern: @"^\"[^\"]*(?:\\[\\s\\S][^\"]*)*\""];
        lineCommentRegex = [[Regex alloc] initWithPattern: @"^//.*"];
        blockCommentRegex = [[Regex alloc] initWithPattern: @"^/[*].*?[*]/"];
        prefixOperatorRegex = [[Regex alloc] initWithPattern: @"^[^\\s,:;\\{\\(\\[]+"];
        postfixOperatorRegex = [[Regex alloc] initWithPattern: @"[^\\s,:;\\)\\}\\]]+$"];
        
        // Keywords...
        declarationKeywords = @{@"class":[NSNumber numberWithInt: LEX_CLASS],
                                @"deinit":[NSNumber numberWithInt: LEX_DEINIT],
                                @"enum":[NSNumber numberWithInt: LEX_ENUM],
                                @"extension":[NSNumber numberWithInt: LEX_EXTENSION],
                                @"func":[NSNumber numberWithInt: LEX_FUNC],
                                @"import":[NSNumber numberWithInt: LEX_IMPORT],
                                @"init":[NSNumber numberWithInt: LEX_INIT],
                                @"let":[NSNumber numberWithInt: LEX_LET],
                                @"protocol":[NSNumber numberWithInt: LEX_PROTOCOL],
                                @"static":[NSNumber numberWithInt: LEX_STATIC],
                                @"struct":[NSNumber numberWithInt: LEX_STRUCT],
                                @"subscript":[NSNumber numberWithInt: LEX_SUBSCRIPT],
                                @"typealias":[NSNumber numberWithInt: LEX_TYPEALIAS],
                                @"var":[NSNumber numberWithInt: LEX_VAR]};
        
        statementKeywords = @{
                              @"break":[NSNumber numberWithInt: LEX_BREAK],
                              @"case":[NSNumber numberWithInt: LEX_CASE],
                              @"continue":[NSNumber numberWithInt: LEX_CONTINUE],
                              @"default":[NSNumber numberWithInt: LEX_DEFAULT],
                              @"do":[NSNumber numberWithInt: LEX_DO],
                              @"else":[NSNumber numberWithInt: LEX_ELSE],
                              @"fallthrough":[NSNumber numberWithInt: LEX_FALLTHROUGH],
                              @"if":[NSNumber numberWithInt: LEX_IF],
                              @"in":[NSNumber numberWithInt: LEX_IN],
                              @"for":[NSNumber numberWithInt: LEX_FOR],
                              @"return":[NSNumber numberWithInt: LEX_RETURN],
                              @"switch":[NSNumber numberWithInt: LEX_SWITCH],
                              @"where":[NSNumber numberWithInt: LEX_WHERE],
                              @"while":[NSNumber numberWithInt: LEX_WHILE],
                              };
        
        expressionKeywords = @{
                               @"as":[NSNumber numberWithInt: LEX_AS],
                               @"dynamictype":[NSNumber numberWithInt: LEX_DYNAMICTYPE],
                               @"is":[NSNumber numberWithInt: LEX_IS],
                               @"new":[NSNumber numberWithInt: LEX_NEW],
                               @"super":[NSNumber numberWithInt: LEX_SUPER],
                               @"self":[NSNumber numberWithInt: LEX_SELF],
                               @"Self":[NSNumber numberWithInt: LEX_SELF_CLASS],
                               @"Type":[NSNumber numberWithInt: LEX_TYPE]
                               };
        
        particularKeywords = @{
                               @"associativity":[NSNumber numberWithInt: LEX_ASSOCIATIVITY],
                               @"didSet":[NSNumber numberWithInt: LEX_DIDSET],
                               @"get":[NSNumber numberWithInt: LEX_GET],
                               @"infix":[NSNumber numberWithInt: LEX_INFIX],
                               @"inout":[NSNumber numberWithInt: LEX_INOUT],
                               @"left":[NSNumber numberWithInt: LEX_LEFT],
                               @"mutating":[NSNumber numberWithInt: LEX_MUTATING],
                               @"none":[NSNumber numberWithInt: LEX_NONE],
                               @"nonmutating":[NSNumber numberWithInt: LEX_NONMUTATING],
                               @"operator":[NSNumber numberWithInt: LEX_OPERATOR],
                               @"override":[NSNumber numberWithInt: LEX_OVERRIDE],
                               @"postfix":[NSNumber numberWithInt: LEX_POSTFIX],
                               @"precedence":[NSNumber numberWithInt: LEX_PRECEDENCE],
                               @"prefix":[NSNumber numberWithInt: LEX_PREFIX],
                               @"right":[NSNumber numberWithInt: LEX_RIGHT],
                               @"set":[NSNumber numberWithInt: LEX_SET],
                               @"unowned":[NSNumber numberWithInt: LEX_UNOWNED],
                               @"unowned(safe)":[NSNumber numberWithInt: LEX_UNOWNED_SAFE],
                               @"unowned(unsafe)":[NSNumber numberWithInt: LEX_UNOWNED_UNSAFE],
                               @"weak":[NSNumber numberWithInt: LEX_WEAK],
                               @"willSet":[NSNumber numberWithInt: LEX_WILLSET],
                               };
        
        operatorSymbols = @{
                            @"/": [NSNumber numberWithInt: LEX_SLASH],       @"=": [NSNumber numberWithInt: LEX_EQUAL],
                            @"-": [NSNumber numberWithInt: LEX_MINUS],       @"+": [NSNumber numberWithInt: LEX_PLUS],
                            @"!": [NSNumber numberWithInt: LEX_EXCLAMATION], @"*": [NSNumber numberWithInt: LEX_ASTERISK],
                            @"%": [NSNumber numberWithInt: LEX_PERCENT],     @"<": [NSNumber numberWithInt: LEX_LT],
                            @">": [NSNumber numberWithInt: LEX_GT],          @"&": [NSNumber numberWithInt: LEX_AMPERSAND],
                            @"|": [NSNumber numberWithInt: LEX_OR],          @"^": [NSNumber numberWithInt: LEX_CARET],
                            @"~": [NSNumber numberWithInt: LEX_TILDE],       @".": [NSNumber numberWithInt: LEX_DOT],
                            //combined
                            @"==": [NSNumber numberWithInt: LEX_EQUAL2],     @"===": [NSNumber numberWithInt: LEX_EQUAL3],
                            @"++": [NSNumber numberWithInt: LEX_PLUSPLUS],   @"--": [NSNumber numberWithInt: LEX_MINUSMINUS],
                            @"...":[NSNumber numberWithInt: LEX_DOT3],       @"->": [NSNumber numberWithInt: LEX_ARROW],
                            @"<<": [NSNumber numberWithInt: LEX_LT2],        @">>": [NSNumber numberWithInt: LEX_GT2],
                            @"&&": [NSNumber numberWithInt: LEX_AMPERSAND2], @"||": [NSNumber numberWithInt: LEX_OR2],
                            @"+=": [NSNumber numberWithInt: LEX_PLUS_EQ],    @"-=": [NSNumber numberWithInt: LEX_MINUS_EQ],
                            @"*=": [NSNumber numberWithInt: LEX_ASTERISK_EQ], @"%=": [NSNumber numberWithInt: LEX_PERCENT_EQ],
                            @"/=": [NSNumber numberWithInt: LEX_SLASH_EQ],   @"|=": [NSNumber numberWithInt: LEX_OR_EQ],
                            @"&=": [NSNumber numberWithInt: LEX_AMPERSAND_EQ], @"^=": [NSNumber numberWithInt: LEX_CARET_EQ],
                            @"~=": [NSNumber numberWithInt: LEX_TILDE_EQ],
                            };
        
        grammarSymbols = @{
                           @"(": [NSNumber numberWithInt: LEX_LPAR],        @")": [NSNumber numberWithInt: LEX_RPAR],
                           @"[": [NSNumber numberWithInt: LEX_LBRACKET],    @"]": [NSNumber numberWithInt: LEX_RBRACKET],
                           @"{": [NSNumber numberWithInt: LEX_LBRACE],      @"}": [NSNumber numberWithInt: LEX_RBRACE],
                           @",": [NSNumber numberWithInt: LEX_COMMA],       @":": [NSNumber numberWithInt: LEX_COLON],
                           @";": [NSNumber numberWithInt: LEX_SEMICOLON],   @"@": [NSNumber numberWithInt: LEX_AT],
                           @"_": [NSNumber numberWithInt: LEX_UNDERSCORE],  @"#": [NSNumber numberWithInt: LEX_HASH],
                           @"$": [NSNumber numberWithInt: LEX_DOLLAR],      @"?": [NSNumber numberWithInt: LEX_QUESTION],
                           };
        
    }
    return self;
}

- (void) cleanCode
{
    NSString *match = nil;
    if((match = [cleanRegex firstMatch:code]) != nil)
    {
        code = [code substringFromIndex:[match lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
        lastParsed = match;
    }
}

- (TokenData *) nextToken
{
    
    if ([tokenStack count] == 0)
    {
        
        [self cleanCode]; //clean whitespaces
        
        //sorted token parser functions by precedence
        NSArray *checkFunctions = @[
                                    @"checkIdentifier",
                                    @"checkNumberLiteral",
                                    @"checkStringLiteral",
                                    @"checkComment",
                                    @"checkOperator",
                                    @"checkGrammarSymbol"
                                    ];
        
        
        // var parsedToken: (consumed:Int, token:TokenData)?;
        
        //call parser functions until a token is found
        for(NSString *checkFunc in checkFunctions)
        {
            SEL sel = NSSelectorFromString(checkFunc);
            [self performSelector:sel];
            if (consumed > 0) {
                lastParsed = [code substringToIndex: consumed];
                code = [code substringFromIndex: consumed];
                consumed = 0;
            }
            if ([tokenStack count] > 0)
            {
                break;
            }
        }
    }
    
    //return the found token and erase the parsed source code
    if([tokenStack count] > 0)
    {
        TokenData *foundToken = [tokenStack objectAtIndex: 0];
        
        [tokenStack removeObjectAtIndex:0];
        if ([foundToken token] == LEX_COMMENT)
        {
            //for now comment tokens are ommited and not pased to the parsed
            return [self nextToken];
        }
        
        return foundToken;
    }
    else
    {
        if ([code lengthOfBytesUsingEncoding:NSUTF8StringEncoding] > 0)
        {
            NSLog(@"Lexer Error, unknown token: %@", code);
        }
        
        return nil;
    }
}

- (int) yylex
{
    TokenData *data = nil;
    lastyylexToken = [self nextToken];
    if((data = lastyylexToken))
    {
        return (int)data.token;
    }
    return 0;
}

- (NSString *) yylexstr
{
    TokenData *data = nil;
    if((data = lastyylexToken))
    {
        return (NSString *)data.value;
    }
    return @"";
}

- (void) checkIdentifier
{
    NSString *match = [identifierRegex firstMatch: code];
    if( match == nil )
    {
        return;
    }
    
    NSString *identifier = match;
    consumed += [identifier lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    int declarationToken = 0; // [declarationKeywords[identifier] intValue];
    int statementToken = 0; // [statementKeywords[identifier] intValue];
    int expressionToken = 0; //  [expressionKeywords[identifier] intValue];
    int particularToken = [particularKeywords[identifier] intValue];
    
    if ((declarationToken = [declarationKeywords[identifier] intValue]))
    {
        TokenData *data = [[TokenData alloc] initWithToken:declarationToken
                                                     value:identifier];
        [tokenStack addObject: data];
    }
    else if ((statementToken = [statementKeywords[identifier] intValue]))
    {
        TokenData *data = [[TokenData alloc] initWithToken:statementToken
                                                     value:identifier];
        [tokenStack addObject: data];
    }
    else if ((expressionToken = [expressionKeywords[identifier] intValue]))
    {
        TokenData *data = [[TokenData alloc] initWithToken:expressionToken
                                                     value:identifier];
        [tokenStack addObject: data];
    }
    else if ((particularToken = [particularKeywords[identifier] intValue]))
    {
        //TODO: These keywords are only reserved in particular contexts
        //but outside the context in which they appear in the grammar, they can be used as identifiers.
        TokenData *data = [[TokenData alloc] initWithToken:particularToken
                                                     value:identifier];
        [tokenStack addObject: data];
    }
    else if([booleanRegex test: identifier])
    {
        TokenData *data = [[TokenData alloc] initWithToken:LEX_BOOLEAN_LITERAL
                                                     value:identifier];
        [tokenStack addObject: data];
    }
    else {
        //user defined identifier
        TokenData *data = [[TokenData alloc] initWithToken:LEX_IDENTIFIER
                                                     value:identifier];
        [tokenStack addObject: data];
    }
}

- (void) checkNumberLiteral
{
    for (Regex *regex in @[binaryNumberRegex, octalNumberRegex, hexNumberRegex, decimalNumberRegex])
    {
        NSString *match = [regex firstMatch:code];
        if (match)
        {
            consumed += [match lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
            TokenData *data = [[TokenData alloc] initWithToken:LEX_NUMBER_LITERAL
                                                         value:match];
            [tokenStack addObject:data];
            return;
        }
    }
}

- (void) checkStringLiteral
{
    NSString *match = [stringRegex firstMatch: code];
    if (match)
    {
        consumed+=[match lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        TokenData *data = [[TokenData alloc] initWithToken:LEX_STRING_LITERAL
                                                     value:match];
        [tokenStack addObject:data];
    }
}

- (void) checkComment
{
    NSString *match = nil;
    if ((match = [lineCommentRegex firstMatch: code]))
    {
        consumed += [match lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        TokenData *data = [[TokenData alloc] initWithToken:LEX_COMMENT
                                                     value:match];
        [tokenStack addObject:data];
    }
    else if ((match = [blockCommentRegex firstMatch: code]))
    {
        consumed += [match lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        TokenData *data = [[TokenData alloc] initWithToken:LEX_COMMENT
                                                     value:match];
        [tokenStack addObject:data];
    }
}

- (void) checkOperator
{
    TOKEN found = 0;
    NSString *value = @"";
    //check operators by precedence (test combined operators first)
    int i = 0;
    for(i = 3; i > 0; --i)
    {
        if([code lengthOfBytesUsingEncoding:NSUTF8StringEncoding] < i)
        {
            continue;
        }
        value = [code substringToIndex:i];
        id match = nil;
        if((match = operatorSymbols[value]))
        {
            found = [match intValue];
            break;
        }
    }
    
    TOKEN token = 0;
    if ((token = found))
    {
        consumed += [value lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        //check if the operator is prefix, postfix or binary
        BOOL prefix = [prefixOperatorRegex test: [code substringFromIndex: [value lengthOfBytesUsingEncoding:NSUTF8StringEncoding]]];
        BOOL postfix = [postfixOperatorRegex test: lastParsed];
        
        if (prefix == postfix) {
            //If an operator has whitespace around both sides or around neither side,
            //it is treated as a binary operator
            TokenData *data = [[TokenData alloc] initWithToken:token
                                                         value:value];
            [tokenStack addObject:data];
        }
        else if (prefix) {
            //prefix unary operator
            TokenData *data = [[TokenData alloc] initWithToken:LEX_PREFIX_OPERATOR
                                                         value:@""];
            [tokenStack addObject:data];
            TokenData *data2 = [[TokenData alloc] initWithToken:token
                                                         value:value];
            [tokenStack addObject:data2];
        }
        else if (postfix) {
            //postfix unary operator
            TokenData *data = [[TokenData alloc] initWithToken:LEX_POSTFIX_OPERATOR
                                                         value:@""];
            [tokenStack addObject:data];
            TokenData *data2 = [[TokenData alloc] initWithToken:token
                                                          value:value];
            [tokenStack addObject:data2];
        }
    }
}

- (void) checkGrammarSymbol
{
    if ([code lengthOfBytesUsingEncoding:NSUTF8StringEncoding] <= 0)
    {
        return;
    }
    
    NSString *firstChar = [code substringToIndex: 1];
    int match = [grammarSymbols[firstChar] intValue];
    
    if ((match))
    {
        consumed += [firstChar lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        TokenData *data = [[TokenData alloc] initWithToken:match
                                                     value:firstChar];
        [tokenStack addObject:data];
    }
}

//debug helper function
- (NSString *) tokenToString: (TOKEN)token
{
    switch (token) {
        case LEX_IDENTIFIER:
            return @"ID";
        case LEX_BOOLEAN_LITERAL:
            return @"bool";
        case LEX_STRING_LITERAL:
            return @"string";
        case LEX_NUMBER_LITERAL:
            return @"number";
        case LEX_PREFIX_OPERATOR:
            return @"prefix_op";
        case LEX_POSTFIX_OPERATOR:
            return @"postfix_op";
        default:
            break;
    }
    
    NSArray *dics = @[declarationKeywords,
                      statementKeywords,
                      expressionKeywords,
                      expressionKeywords,
                      particularKeywords,
                      operatorSymbols,
                      grammarSymbols];
    
    for(NSDictionary *dic in dics)
    {
        NSArray *allKeys = [dic allKeys];
        for(id key in allKeys)
        {
            id value = [dic objectForKey:key];
            if([value intValue] == token)
            {
                return key;
            }
        }
    }
    
    return @"unknown";
}

//debug function
- (void) debugTokens
{
    NSString *codeCopy = [code copy];
    
    TokenData *data = nil;
    while ((data = [self nextToken]))
    {
        NSString *tokenType = [self tokenToString: data.token];
        NSLog(@"TOKEN code: %lu type:%@ value:%@", (unsigned long)data.token, tokenType, data.value);
    }
    
    code = codeCopy;
}

//helper function to generate bison tokens
- (void) bisonTokens
{
    //autogenerated values from text editor
    NSArray *values = @[@"IDENTIFIER",
                        @"CLASS",@"DEINIT",@"ENUM",@"EXTENSION",@"FUNC",@"IMPORT",@"INIT",@"LET",@"PROTOCOL",@"STATIC",@"STRUCT",@"SUBSCRIPT",@"TYPEALIAS",@"VAR",
                        @"BREAK",@"CASE",@"CONTINUE",@"DEFAULT",@"DO",@"ELSE",@"FALLTHROUGH",@"IF",@"IN",@"FOR",@"RETURN",@"SWITCH",@"WHERE",@"WHILE",
                        @"AS",@"DYNAMICTYPE",@"IS",@"NEW",@"SUPER",@"SELF",@"SELF_CLASS",@"TYPE",
                        @"ASSOCIATIVITY",@"DIDSET",@"GET",@"INFIX",@"INOUT",@"LEFT",@"MUTATING",@"NONE",@"NONMUTATING",@"OPERATOR",@"OVERRIDE",
                        @"POSTFIX",@"PRECEDENCE",@"PREFIX",@"RIGHT",@"SET",@"UNOWNED",@"UNOWNED_SAFE",@"UNOWNED_UNSAFE",@"WEAK",@"WILLSET",
                        @"NUMBER_LITERAL",@"STRING_LITERAL",@"BOOLEAN_LITERAL",
                        @"SLASH",@"EQUAL",@"MINUS",@"PLUS",@"EXCLAMATION",@"ASTERISK",@"PERCENT",@"LT",@"GT",@"AMPERSAND",@"OR",@"CARET",@"TILDE",@"DOT",
                        @"EQUAL2",@"EQUAL3",@"PLUSPLUS",@"MINUSMINUS",@"DOT3",@"LT2",@"GT2",@"AMPERSAND2",@"OR2",@"ARROW",
                        @"PLUS_EQ",@"MINUS_EQ",@"ASTERISK_EQ",@"SLASH_EQ",@"PERCENT_EQ",@"AMPERSAND_EQ",@"CARET_EQ",@"TILDE_EQ",@"OR_EQ",
                        @"LPAR",@"RPAR",@"LBRACKET",@"RBRACKET",@"LBRACE",@"RBRACE",@"COMMA",@"COLON",@"SEMICOLON",@"AT",@"UNDERSCORE",@"HASH",@"DOLLAR",@"QUESTION",
                        @"PREFIX_OPERATOR",@"POSTFIX_OPERATOR",
                        @"COMMENT"];
    
    int index = 1;
    char percent = '%';
    for (NSString *value in values)
    {
        TOKEN token = (TOKEN)index; // TOKEN.fromRaw(index)!;
        NSString *str = [self tokenToString: token];
        NSString *outputString = [NSString stringWithFormat:@"%ctoken <val> %@ %ul %@",percent, value, index, str];
        
        printf("%s",[outputString cStringUsingEncoding:NSUTF8StringEncoding]);
        
        index++;
    }
}



@end
