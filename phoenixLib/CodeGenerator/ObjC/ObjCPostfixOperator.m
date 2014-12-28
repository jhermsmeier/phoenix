#import "ObjCPostfixOperator.h"

@implementation ObjCPostfixOperator

- (NSString *) toCode
{
    return [NSString stringWithFormat:@"%@%@", [self.operand toCode], self.postfixOperator];
}

@end
