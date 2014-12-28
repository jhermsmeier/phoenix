#import "ObjCStatementsNode.h"
#import "ASTContext.h"

@implementation ObjCStatementsNode

- (NSString *)toCode
{
    if (self.firstStatement)
    {
        [ctx saveSymbols];
    }
    
    NSString *result = @"";
    ASTNode *currentStatement = self.current;
    if (currentStatement)
    {
        [ctx saveExported];
        NSString *tmp = [[currentStatement toCode] stringByAppendingString:@"\n"];

        NSString *exported = [ctx getExportedVars];
        if(exported)
        {
            result = [result stringByAppendingString:exported];
        }
        result = [result stringByAppendingString:tmp];
        [ctx restoreExported];
    }
    
    StatementsNode *nextStatements =  (StatementsNode *)self.next;
    if(nextStatements)
    {
        nextStatements.firstStatement = NO;
        result = [result stringByAppendingString:[nextStatements toCode]];
    }

    if (self.firstStatement)
    {
        [ctx restoreSymbols];
    }
    
    return result;
}

@end
