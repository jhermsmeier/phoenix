#import "ObjCIfStatement.h"
#import "Functions.h"

@implementation ObjCIfStatement

- (NSString *)toCode
{
    NSString *result = @"if (";
    result = [result stringByAppendingString:[self.ifCondition toCode]];
    result = [result stringByAppendingString:@") {\n"];
    ASTNode *statements = self.body;
    if(statements)
    {
        NSString *string = tabulate([statements toCode]);
        result = [result stringByAppendingString:string];
    }
    result = [result stringByAppendingString:@"}"];
    ASTNode *next = self.elseClause;
    if(next)
    {
        result = [result stringByAppendingString:@"\nelse"];
        if([next isKindOfClass:[IfStatement class]])
        {
            result = [result stringByAppendingString:[next toCode]];
        }
        else
        {
            NSString *string = [NSString stringWithFormat:@"{\n %@ }",tabulate([next toCode])];
            result = [result stringByAppendingString:string];
        }
    }
    
    return result;
}

@end
