#import "ASTNode.h"

@interface PrefixOperator : ASTNode

@property (nonatomic, retain) ASTNode *operand;
@property (nonatomic, retain) NSString *prefixOperator;

- (id) init: (ASTNode *)operand
           : (NSString *)prefixOperator;
// - (NSString *) toCode
// - (GenericType *) inferType;
@end
