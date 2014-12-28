#import "AST.h"

@implementation BinaryOperator

@synthesize rightOperand, binaryOperator;

- (id) initWithRightOperand: (ASTNode *)arightOperand
             binaryOperator: (NSString *)abinaryOperator
{
    self = [super init];
    if(self)
    {
        self.rightOperand = arightOperand;
        self.binaryOperator = abinaryOperator;
    }
    return self;
}

- (NSString *) codeForIndex: (NSInteger)index
{
    return [NSString stringWithFormat:@"[%ld]",index];
}

- (GenericType *) inferType
{
    return [self.rightOperand getType];
}

@end
