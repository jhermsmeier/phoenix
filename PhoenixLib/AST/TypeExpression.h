#import "ASTNode.h"

@interface TypeExpression: ASTNode
@property (nonatomic, retain) GenericType *linkedType;
- (id) initWithLinkedType: (GenericType *)linkedType;
// - (NSString *)toCode;
// - (GenericType *)inferType;
@end
