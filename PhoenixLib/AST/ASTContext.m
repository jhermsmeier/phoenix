#import "AST.h"

@implementation ASTContext

@synthesize exportedIndex, exportedVars, symbols, symbolsIndex, generateIDIndex;

- (id) init
{
    if(ctx != nil)
    {
        return ctx;
    }
    else
    {
        self = [super init];
        if(self != nil)
        {
            ctx = self;  // set global context...
            self.exportedVars = [[NSMutableArray alloc] init];  // array of arrays of exported variables...
            self.exportedIndex = 0;
            self.symbols = [[NSMutableArray alloc] init];  // Array of ASTSymbolTable objects...
            self.symbolsIndex = -1;
            self.generateIDIndex = 0;
        }
        return self;
    }
    return nil;
}

- (NSString *)variableDeclaration
{
    return @"id"; // temporary
}

- (NSString *)declarationSeparator
{
    return @","; // temporary...
}

// Methods.
- (NSString *)generateID
{
    return [NSString stringWithFormat:@"_ref%ld",
            (long)self.generateIDIndex++];
}

- (BOOL) _find: (NSString *)name
{
    if([self.exportedVars count] < self.symbolsIndex)
    {
        [self saveExported];
    }
    
    NSArray *array = [self.exportedVars objectAtIndex:self.exportedIndex];
    return [array containsObject:name];
}

- (void) exportVar: (NSString *)name
{
    if(![self _find:name])
    {
        [[self.exportedVars objectAtIndex:self.exportedIndex] addObject:name];
    }
}

- (NSString *)getExportedVars
{
    if ([[self.exportedVars objectAtIndex: self.exportedIndex - 1] count] > 0)
    {
        NSString *result = @"";
        result = [result stringByAppendingString:[self variableDeclaration]];
        for (NSString *variable in [self.exportedVars objectAtIndex:self.exportedIndex])
        {
            result = [result stringByAppendingString:
                      [variable stringByAppendingString: [self declarationSeparator]]];
        }
        
        result = [result substringFromIndex:
                  [result lengthOfBytesUsingEncoding:NSUTF8StringEncoding] - 1];
        result = [result stringByAppendingString:@";\n"];
        return result;
    }
    return nil;
}

- (void) saveExported
{
    self.exportedIndex++;
    [self.exportedVars addObject:[NSMutableArray array]];
}

- (void) restoreExported
{
    if(self.exportedIndex > 0)
    {
        [self.exportedVars removeLastObject];
        self.exportedIndex--;
    }
}

- (void) saveSymbols
{
    self.symbolsIndex++;
    [self.symbols addObject:[NSMutableArray array]];
}

- (void) restoreSymbols
{
    if(self.symbolsIndex > 0)
    {
        [self.symbols removeLastObject];
        self.symbolsIndex--;
    }
}

- (void) addSymbolName: (NSString *)name
                  type: (GenericType *)type
{
    if([self.symbols count] < self.symbolsIndex)
    {
        ASTSymbolTable *table = [[ASTSymbolTable alloc] init];
        [self.symbols addObject:table];
    }
    
    
    if(self.symbolsIndex < 0)
    {
        [self saveSymbols];
    }
    
    [[self.symbols objectAtIndex:self.symbolsIndex] setObject:type
                                                       forKey:name];
}

- (GenericType *)inferSymbol: (NSString *)name
{
    for(NSInteger i = self.symbolsIndex; i >= 0; --i)
    {
        GenericType *type = [[self.symbols objectAtIndex:i] objectForKey:name];
        if(type != nil)
        {
            return type;
        }
    }
    return nil;
}

@end
