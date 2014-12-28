#import "ASTNode.h"

@interface LabelStatement : ASTNode
@property (nonatomic, retain) NSString *labelName;
@property (nonatomic, retain) ASTNode *loop;

- (id) initWithLabelName: (NSString *)labelName
                    loop: (ASTNode *)loop;
// - (NSString *)toCode;
@end
