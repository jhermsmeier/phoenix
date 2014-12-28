#import "AST.h"

@implementation StatementNode

@synthesize statement;

- (id) initWithStatement: (ASTNode *)astatement
{
    self = [super init];
    if(self)
    {
        self.statement = astatement;
    }
    return self;
}

@end
