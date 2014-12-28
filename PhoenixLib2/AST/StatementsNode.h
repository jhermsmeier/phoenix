#import "ASTNode.h"

@interface StatementsNode : ASTNode
@property (nonatomic, retain) ASTNode *current;
@property (nonatomic, retain) ASTNode *next;
@property (nonatomic, assign) BOOL firstStatement;

- (id) initWithCurrent: (ASTNode *)current;
- (id) initWithCurrent: (ASTNode *)current
                  next: (StatementsNode *)next;

// - (NSString *)toCode;
- (NSInteger) getStatementsCount;
@end
