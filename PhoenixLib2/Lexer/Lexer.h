//
//  Lexer.h
//  swift2js
//
//  Created by Gregory Casamento on 10/19/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    LEX_IDENTIFIER = 1,
    //declaration keywords
    LEX_CLASS, LEX_DEINIT, LEX_ENUM, LEX_EXTENSION, LEX_FUNC, LEX_IMPORT, LEX_INIT, LEX_LET, LEX_PROTOCOL, LEX_STATIC, LEX_STRUCT, LEX_SUBSCRIPT, LEX_TYPEALIAS, LEX_VAR,
    //statement keywords
    LEX_BREAK, LEX_CASE, LEX_CONTINUE, LEX_DEFAULT, LEX_DO, LEX_ELSE, LEX_FALLTHROUGH, LEX_IF, LEX_IN, LEX_FOR, LEX_RETURN, LEX_SWITCH, LEX_WHERE, LEX_WHILE,
    //expression keywwords
    LEX_AS, LEX_DYNAMICTYPE, LEX_IS, LEX_NEW, LEX_SUPER, LEX_SELF, LEX_SELF_CLASS, LEX_TYPE,
    //particular keywords
    LEX_ASSOCIATIVITY, LEX_DIDSET, LEX_GET, LEX_INFIX, LEX_INOUT, LEX_LEFT, LEX_MUTATING, LEX_NONE, LEX_NONMUTATING, LEX_OPERATOR, LEX_OVERRIDE,
    LEX_POSTFIX, LEX_PRECEDENCE, LEX_PREFIX, LEX_RIGHT, LEX_SET, LEX_UNOWNED, LEX_UNOWNED_SAFE, LEX_UNOWNED_UNSAFE, LEX_WEAK, LEX_WILLSET,
    //value literals
    LEX_NUMBER_LITERAL, LEX_STRING_LITERAL, LEX_BOOLEAN_LITERAL,
    //operators /­  =­  -­  +­  !­  *­  %­  <­  >­  &­  |­  ^­  ~­  .­
    LEX_SLASH, LEX_EQUAL, LEX_MINUS, LEX_PLUS, LEX_EXCLAMATION, LEX_ASTERISK, LEX_PERCENT, LEX_LT, LEX_GT, LEX_AMPERSAND, LEX_OR, LEX_CARET, LEX_TILDE, LEX_DOT,
    //combined operators == === ++ -- ... << >> && || ->
    //+= -= *= %= /= &= |= ^= ~=
    LEX_EQUAL2, LEX_EQUAL3, LEX_PLUSPLUS, LEX_MINUSMINUS, LEX_DOT3, LEX_LT2, LEX_GT2, LEX_AMPERSAND2, LEX_OR2, LEX_ARROW,
    LEX_PLUS_EQ, LEX_MINUS_EQ, LEX_ASTERISK_EQ, LEX_SLASH_EQ, LEX_PERCENT_EQ, LEX_AMPERSAND_EQ, LEX_CARET_EQ, LEX_TILDE_EQ, LEX_OR_EQ,
    //grammar symbols ( ) [ ] { } , : ; @ _ # $ ?
    LEX_LPAR, LEX_RPAR, LEX_LBRACKET, LEX_RBRACKET, LEX_LBRACE, LEX_RBRACE, LEX_COMMA, LEX_COLON, LEX_SEMICOLON, LEX_AT, LEX_UNDERSCORE, LEX_HASH, LEX_DOLLAR, LEX_QUESTION,
    //helper tokens to resolve operator ambiguities
    LEX_PREFIX_OPERATOR, LEX_POSTFIX_OPERATOR,
    //line or block comment
    LEX_COMMENT
};
typedef NSUInteger TOKEN;

// Token data...
@interface TokenData : NSObject <NSObject, NSCopying>

@property (nonatomic,assign) TOKEN token;
@property (nonatomic,strong) NSString *value;

- (id)initWithToken:(TOKEN)token
              value:(NSString *)value;

@end

// Lexer

@class Regex;

@interface Lexer : NSObject
{
    NSString *code;
    NSString *lastParsed;
    NSUInteger consumed;
    NSMutableArray *tokenStack;
    BOOL debugYYLex;
    Regex *cleanRegex;
    Regex *identifierRegex;
    Regex *binaryNumberRegex;
    Regex *octalNumberRegex;
    Regex *hexNumberRegex;
    Regex *decimalNumberRegex;
    Regex *booleanRegex;
    Regex *stringRegex;
    Regex *lineCommentRegex;
    Regex *blockCommentRegex;
    Regex *prefixOperatorRegex;
    Regex *postfixOperatorRegex;
    NSDictionary *declarationKeywords;
    NSDictionary *statementKeywords;
    NSDictionary *expressionKeywords;
    NSDictionary *particularKeywords;
    NSDictionary *operatorSymbols;
    NSDictionary *grammarSymbols;
}

- (id) initWithSourceCode: (NSString *)theCode;

- (void) cleanCode;

- (TokenData *) nextToken;

- (int) yylex;

- (NSString *) yylexstr;

- (void) checkIdentifier;

- (void) checkNumberLiteral;

- (void) checkStringLiteral;

- (void) checkComment;

- (void) checkOperator;

- (void) checkGrammarSymbol;

//debug helper function
- (NSString *) tokenToString: (TOKEN)token;

//debug function
- (void) debugTokens;

//helper function to generate bison tokens
- (void) bisonTokens;
@end
