#import "ASTNode.h"

@interface StatementNode : ASTNode
@property (nonatomic, retain) ASTNode *statement;

- (id) initWithStatement: (ASTNode *)statement;
// - (NSString *)toCode;
@end
