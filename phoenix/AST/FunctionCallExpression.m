#import "AST.h"

@implementation FunctionCallExpression

@synthesize function, parenthesized;

- (id) initWithFunction: (ASTNode *)afunction
          parenthesized: (ParenthesizedExpression *)aparenthesized
{
    self = [super init];
    if(self)
    {
        self.function = afunction;
        self.parenthesized = aparenthesized;
    }
    return self;
}

- (GenericType *)inferType
{
    FunctionType *funcType = (FunctionType *)(AS([self.function getType], [FunctionType class]));
    if(funcType != nil)
    {
        return [funcType returnType];
    }
    return [[GenericType alloc] initWithType:TYPE_VOID];
}
@end
