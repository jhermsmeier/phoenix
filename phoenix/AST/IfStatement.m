#import "AST.h"

@implementation IfStatement

@synthesize ifCondition, body, elseClause;

- (id) initWithIfCondition: (ASTNode *)anifCondition
                      body: (ASTNode *)abody
                elseClause: (ASTNode *)anelseClause
{
    self = [super init];
    if(self)
    {
        self.ifCondition = anifCondition;
        self.body = abody;
        self.elseClause = anelseClause;
    }
    return self;
}


@end
