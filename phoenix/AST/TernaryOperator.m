#import "AST.h"

@implementation TernaryOperator
- (id) initWithTrueOperand: (ASTNode *)atrueOperand
              falseOperand: (ASTNode *)afalseOperand
{
    self = [super init];
    if(self)
    {
        self.trueOperand = atrueOperand;
        self.falseOperand = afalseOperand;
    }
    return self;
}

- (GenericType *) inferType
{
    return [self.trueOperand getType];
}
@end
