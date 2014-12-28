#import "ObjCBinaryOperator.h"

@implementation ObjCBinaryOperator

@synthesize rightOperand, binaryOperator;

- (NSString *) toCode
{
    if([self.binaryOperator isEqualToString:@"."])
    {
        NSString *right = [self.rightOperand toCode];
        NSInteger index = [right integerValue];
        if(!isnan(index))
        {
            return [self codeForIndex:index];
        }
        return [NSString stringWithFormat: @"%@%@",self.binaryOperator, right];
    }
    
    // else...
    return [NSString stringWithFormat: @" %@ %@",self.binaryOperator,
            [self.rightOperand toCode]];
}

@end
