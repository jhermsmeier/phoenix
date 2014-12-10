#import "AST.h"

@implementation DictionaryLiteral

@synthesize pairs;

- (id) initWithPairs: (ASTNode *)apairs
{
    self = [super init];
    if(self)
    {
        self.pairs = apairs;
    }
    return self;
}


- (GenericType *)inferType
{
    ExpressionList *item = (ExpressionList *)(AS(self.pairs, [ExpressionList class]));
    ASTNode *current = [item current];
    if(current)
    {
        return [[DictionaryType alloc] initWithInnerType:[item getType]];
    }

    return [[DictionaryType alloc] initWithInnerType:
            [[GenericType alloc] initWithType:TYPE_UNKNOWN]];
}

@end
