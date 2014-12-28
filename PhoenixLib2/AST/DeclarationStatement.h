#import "ASTNode.h"

@interface DeclarationStatement : ASTNode
@property (nonatomic, retain) ASTNode *declaration;

- (id) initWithDeclaration: (ASTNode *)declaration;
// - (NSString *)toCode;
@end
