#import "ASTNode.h"

@interface OptionalChainExprStatement : ASTNode
@property (nonatomic, retain) ASTNode *optChainExpr;

- (id) initWithOptChainExpr:  (ASTNode *)optChainExpr;
// - (NSString *)toCode;
// - (GenericType *)inferType;
@end
