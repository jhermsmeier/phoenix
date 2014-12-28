#import "ASTNode.h"

@interface ImportStatement : ASTNode
@property (nonatomic, retain) NSString *path;

- (id) initWithPath: (NSString *)path;
// - (NSString *)toCode;
@end
