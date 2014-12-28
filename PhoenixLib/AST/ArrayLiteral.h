#import "ASTNode.h"

@interface ArrayLiteral: ASTNode

@property (nonatomic, retain) ASTNode *items;

- (id) initWithItems: (ASTNode *)items;
// - (NSString *)toCode;
// - (GenericType *)inferType;
@end
