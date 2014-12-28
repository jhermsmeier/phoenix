#import "ASTNode.h"

@interface FunctionDeclaration : ASTNode
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) ASTNode *signature;
@property (nonatomic, retain) ASTNode *body;

- (id) initWithName: (NSString *)name
          signature: (ASTNode *)signature
               body: (ASTNode *)body;

// - (NSString *)toCode;
// - (GenericType *)inferType;
@end
