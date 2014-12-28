#import "ASTNode.h"

@interface LiteralExpression: ASTNode
@property (nonatomic, retain) NSString *value;
- (id) init: (NSString *)literal;
// - (NSString *) toCode
// - (GenericType *) inferType;
@end
