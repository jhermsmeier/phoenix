#import "ASTNode.h"

@interface WhileStatement : ASTNode
@property (nonatomic, retain) ASTNode *whileCondition;
@property (nonatomic, retain) ASTNode *codeBlock;

- (id)initWithWhileCondition: (ASTNode *)whileCondition
                   codeBlock: (ASTNode *)codeBlock;
// - (NSString *)toCode;
@end
