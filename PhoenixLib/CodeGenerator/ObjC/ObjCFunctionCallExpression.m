#import "ObjCFunctionCallExpression.h"
#import "ParenthesizedExpression.h"

@implementation ObjCFunctionCallExpression

- (NSString *)toCode
{
    self.parenthesized.allowInlineTuple = NO;
    return [NSString stringWithFormat:@"%@%@",[self.function toCode],[self.parenthesized toCode]];
}

@end
