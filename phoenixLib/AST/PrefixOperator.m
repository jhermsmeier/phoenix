#import "AST.h"

@implementation PrefixOperator

@synthesize operand, prefixOperator;

- (id) init: (ASTNode *)anoperand
           : (NSString *)aprefixOperator;
{
    self = [super init];
    if(self)
    {
        self.operand = anoperand;
        self.prefixOperator = aprefixOperator;
    }
    return self;
}

- (GenericType *) inferType
{
    return [self.operand getType];
}

@end
