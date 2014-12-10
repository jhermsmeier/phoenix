#import "ObjCVariableDeclaration.h"
#import "BinaryExpression.h"

@implementation ObjCVariableDeclaration

- (NSString *) toCode
{
    
    NSString *result = [self.initializer toCode];
    
    //export symbols and vars
    ExpressionList *node = self.initializer;
    ExpressionList *item = nil;
    while ((item = node) != nil)
    {
        BinaryExpression *binaryExpr = (BinaryExpression *)(AS([item current], [BinaryExpression class]));
        if (binaryExpr)
        {
            [self exportSymbols:[binaryExpr current]];
        }
        else
        {
            [self exportSymbols:[item current]];
        }
        node = item.next;
    }
    
    //avoid var if exporting variables
    if (self.exportVariables)
    {
        return result;
    }

    return [NSString stringWithFormat:@"id %@", result];
}

@end
