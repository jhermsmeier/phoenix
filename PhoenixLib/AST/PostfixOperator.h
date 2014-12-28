#import "ASTNode.h"

@interface PostfixOperator : ASTNode

@property (nonatomic, retain) ASTNode *operand;
@property (nonatomic, retain) NSString *postfixOperator;

- (id) init: (ASTNode *)operand
           : (NSString *)prefixOperator;
// - (NSString *) toCode
// - (GenericType *) inferType;
@end
