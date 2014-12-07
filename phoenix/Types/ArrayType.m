#import <Foundation/Foundation.h>
#import "Types.h"

@implementation ArrayType

@synthesize innerType;

- (id) initWithInnerType: (GenericType *)aninnerType
{
    self = [super initWithType:TYPE_ARRAY];
    if(self != nil)
    {
        self.innerType = aninnerType;
    }
    return self;
}

- (NSString *)customBinaryOperator:(ASTNode *)myNode :(NSString *)op :(ASTNode *)otherNode
{
    if([op isEqualToString:@"+="])
    {
        if(otherNode.type.type == TYPE_ARRAY)
        {
            return [NSString stringWithFormat:@"[%@ addObjectsFromArray:%@]",[myNode toCode], [otherNode toCode]];
        }
        else
        {
            return [NSString stringWithFormat:@"[%@ addObjectsFromArray:%@]",[myNode toCode], [otherNode toCode]];
        }
        
        return [super customBinaryOperator:myNode :op :otherNode];
    }
    return nil;
}
@end
