#import "ObjCWhileStatement.h"
#import "Functions.h"

@implementation ObjCWhileStatement

- (NSString *)toCode
{
    NSString *result = @"while";
    
    result = [result stringByAppendingString:[NSString stringWithFormat:@"( %@ ) { \n", [self.whileCondition toCode]]];
    ASTNode *statements = self.codeBlock;
    if(statements)
    {
        NSString *string = tabulate([statements toCode]);
        result = [result stringByAppendingString:string];
    }
    
    
    result = [result stringByAppendingString:@"}"];
    return result;
}

@end
