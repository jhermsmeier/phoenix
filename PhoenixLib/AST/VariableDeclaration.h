#import "ASTNode.h"
#import "ExpressionList.h"

@interface VariableDeclaration : ASTNode

@property (nonatomic, retain) ExpressionList *initializer;
@property (nonatomic, assign) BOOL exportVariables;

- (id) initWithInitializer: (ExpressionList *)initializer;
- (void) exportSymbols: (ASTNode *)expression;

// - (NSString *) toCode;
@end
