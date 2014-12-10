#import "AST.h"

@implementation VariableDeclaration

@synthesize initializer;

- (id) initWithInitializer: (ExpressionList *)aninitializer
{
    self = [super init];
    if(self)
    {
        self.initializer = aninitializer;
    }
    return self;
}

- (void) exportSymbols: (ASTNode *)expression
{
    if(expression == nil)
    {
        return;
    }
    
    ParenthesizedExpression *tuple = (ParenthesizedExpression *)(AS(expression, [ParenthesizedExpression class]));
    if(tuple != nil)
    {
        NSArray *names = [tuple toExpressionArray];
        NSArray *types = [tuple toTypesArray];
        int i = 0;
        for(i = 0; i < [names count]; i++)
        {
            NSString *name = [[names objectAtIndex:i] toCode];
            if(self.exportVariables)
            {
                [ctx exportVar:name];
            }
            [ctx addSymbolName:name type:[types objectAtIndex:i]];
        }
    }
    else
    {
        NSString *name = [expression toCode];
        if(self.exportVariables)
        {
            [ctx exportVar:name];
        }
        [ctx addSymbolName:name type:[expression getType]];
    }
}

@end
