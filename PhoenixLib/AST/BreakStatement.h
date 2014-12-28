#import "ASTNode.h"

@interface BreakStatement : ASTNode
@property (nonatomic, retain) NSString *labelName;

- (id) initWithLabelId: (NSString *)labelName;
// - (NSString *)toCode;
@end
