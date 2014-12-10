#import "ObjCOptionalChainExprStatement.h"

@implementation ObjCOptionalChainExprStatement

@synthesize optChainExpr;

- (NSString *)toCode
{
    ASTNode *expr = self.optChainExpr;
    if(expr)
    {
        return [expr toCode];
    }
    return @"";
}

@end
