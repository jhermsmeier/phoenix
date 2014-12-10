#import "ObjCNamedExpression.h"

@implementation ObjCNamedExpression

- (NSString *)toCode
{
    return [self.expr toCode];
}

@end
