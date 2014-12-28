#import "ASTNode.h"

@interface BinaryOperator : ASTNode
@property (nonatomic, retain) ASTNode *rightOperand;
@property (nonatomic, retain) NSString *binaryOperator;

- (id) initWithRightOperand: (ASTNode *)rightOperand
             binaryOperator: (NSString *)binaryOperator;
- (NSString *) codeForIndex: (NSInteger)index;
// - (NSString *) toCode
// - (GenericType *) inferType;
@end
