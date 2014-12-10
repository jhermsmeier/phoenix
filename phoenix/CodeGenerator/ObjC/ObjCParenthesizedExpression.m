#import "ObjCParenthesizedExpression.h"
#import "NamedExpression.h"
#import "ExpressionList.h"

@implementation ObjCParenthesizedExpression

- (NSString *)toCode
{
    
    if (self.allowInlineTuple)
    {
        ExpressionList *list = (ExpressionList *)(AS(self.expression, [ExpressionList class]));
        if (list)
        {
            if (([list next]) != nil)
            {
                return [self toInlineTuple: list];
            }
        }
    }
    
    ExpressionList *expr = nil;
    if ((expr = (ExpressionList *)self.expression) != nil)
    {
        NSString *result = [NSString stringWithFormat:@"(%@)",[expr toCode]];
        return result;
    }

    return @"()";
}

@end
