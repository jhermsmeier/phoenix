#import "ObjCReturnStatement.h"
#import "Types.h"

@implementation ObjCReturnStatement

- (NSString *)toCode
{
    ASTNode *expr = self.returnExpr;
    if (expr)
    {
        return [NSString stringWithFormat:@"return %@;", [expr toCode]];
    }
    return @"return;";
}

@end
