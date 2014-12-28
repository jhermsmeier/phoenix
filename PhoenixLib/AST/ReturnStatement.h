#import "ASTNode.h"

@interface ReturnStatement : ASTNode
@property (nonatomic, retain) ASTNode *returnExpr;

- (id) initWithReturnExpr:  (ASTNode *)returnExpr;
// - (NSString *)toCode;
// - (GenericType *)inferType;
@end
