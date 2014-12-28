#import "ASTNode.h"

@interface IdentifierExpression: ASTNode
@property (nonatomic, retain) NSString *name;
- (id) init: (NSString *)identifier;
// - (NSString *) toCode
// - (GenericType *) inferType;
@end
