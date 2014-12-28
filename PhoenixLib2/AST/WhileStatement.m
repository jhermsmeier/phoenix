#import "AST.h"

@implementation WhileStatement

@synthesize whileCondition, codeBlock;

- (id)initWithWhileCondition: (ASTNode *)awhileCondition
                   codeBlock: (ASTNode *)acodeBlock
{
    self = [super init];
    if(self)
    {
        self.whileCondition = awhileCondition;
        self.codeBlock = acodeBlock;
    }
    return self;
}

@end
