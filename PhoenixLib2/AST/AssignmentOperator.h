#import "ASTNode.h"

@interface AssignmentOperator : ASTNode

@property (nonatomic, retain) ASTNode *rightOperand;

- (id) initWithRightOperand: (ASTNode *)rightOperand;
// - (NSString *) toCode
// - (GenericType *) inferType;
@end
