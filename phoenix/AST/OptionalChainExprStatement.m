#import "AST.h"

@implementation OptionalChainExprStatement

@synthesize optChainExpr;

- (id) initWithOptChainExpr:  (ASTNode *)anoptChainExpr
{
    self = [super init];
    if(self)
    {
        self.optChainExpr = anoptChainExpr;
    }
    return self;
}

@end
