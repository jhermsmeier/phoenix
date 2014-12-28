#import "AST.h"

@implementation ArrayLiteral

@synthesize items;

- (id) initWithItems: (ASTNode *)anitems
{
    self = [super init];
    if(self)
    {
        self.items = anitems;
    }
    return self;
}

- (GenericType *)inferType
{
    ExpressionList *node = (ExpressionList *)(AS(self.items,
                                                 [ExpressionList class]));
    ASTNode *item = [node current];
    if(item)
    {
        return [[ArrayType alloc] initWithInnerType:[item getType]];
    }
    return [[ArrayType alloc] initWithInnerType:
            [[GenericType alloc] initWithType:TYPE_UNKNOWN]];
}
@end
