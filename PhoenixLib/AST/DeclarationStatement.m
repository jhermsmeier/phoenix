#import "AST.h"

@implementation DeclarationStatement

- (id) initWithDeclaration: (ASTNode *)adeclaration
{
    self = [super init];
    if(self)
    {
        self.declaration = adeclaration;
    }
    return self;
}

@end
