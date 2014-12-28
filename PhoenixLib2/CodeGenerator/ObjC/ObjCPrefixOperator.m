#import "ObjCPrefixOperator.h"

@implementation ObjCPrefixOperator

- (NSString *) toCode
{
    return [NSString stringWithFormat:@"%@%@",self.prefixOperator, [self.operand toCode]];
}

@end
