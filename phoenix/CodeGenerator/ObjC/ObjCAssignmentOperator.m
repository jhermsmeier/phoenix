#import "ObjCAssignmentOperator.h"

@implementation ObjCAssignmentOperator

- (NSString *) toCode
{
    return [NSString stringWithFormat:@" = %@",[self.rightOperand toCode]];
}

@end
