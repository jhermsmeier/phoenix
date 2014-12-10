#import "ObjCExpressionList.h"

@implementation ObjCExpressionList

- (NSString *)toCode
{
    NSString *result = @"";
    ASTNode *currentExpression = self.current;
    if (currentExpression)
    {
        result = [result stringByAppendingString:[currentExpression toCode]];
    }
    
    ExpressionList *nextExpression = self.next;
    if (nextExpression)
    {
        result = [result stringByAppendingString: [NSString stringWithFormat:@", %@", [nextExpression toCode]]];
    }
    return result;
}

@end
