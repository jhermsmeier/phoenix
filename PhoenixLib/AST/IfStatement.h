#import "ASTNode.h"

@interface IfStatement : ASTNode
@property (nonatomic, retain) ASTNode *ifCondition;
@property (nonatomic, retain) ASTNode *body;
@property (nonatomic, retain) ASTNode *elseClause;

- (id) initWithIfCondition: (ASTNode *)ifCondition
                      body: (ASTNode *)body
                elseClause: (ASTNode *)elseClause;

// - (NSString *)toCode;
@end
