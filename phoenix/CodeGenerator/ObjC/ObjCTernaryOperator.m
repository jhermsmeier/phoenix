#import "ObjCTernaryOperator.h"

@implementation ObjCTernaryOperator

- (NSString *) toCode
{
    return [NSString stringWithFormat:@" ? %@ : %@",
            [self.trueOperand toCode],
            [self.falseOperand toCode]];
}

@end
