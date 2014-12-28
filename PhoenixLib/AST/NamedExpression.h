#import "ASTNode.h"

@interface NamedExpression: ASTNode
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) ASTNode *expr;
- (id) initWithName: (NSString *)name
               expr: (ASTNode *)expr;
// - (NSString *)toCode;
// - (GenericType *)inferType;
@end
