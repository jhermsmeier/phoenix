#import "ASTNode.h"

@interface TernaryOperator : ASTNode

@property (nonatomic, retain) ASTNode *trueOperand;
@property (nonatomic, retain) ASTNode *falseOperand;

- (id) initWithTrueOperand: (ASTNode *)trueOperand
              falseOperand: (ASTNode *)falseOperand;
// - (NSString *) toCode
// - (GenericType *) inferType;
@end
