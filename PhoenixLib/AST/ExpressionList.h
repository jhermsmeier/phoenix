#import "ASTNode.h"

@interface ExpressionList : ASTNode
@property (nonatomic, retain) ASTNode *current;
@property (nonatomic, retain) ExpressionList *next;
- (id)initWithExpr: (ASTNode *)expr
              next: (ExpressionList *)next;
// - (NSString *)toCode;
// - (GenericType *)inferType;
@end
