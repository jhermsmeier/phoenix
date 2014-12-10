#import "AST.h"

@implementation FunctionDeclaration

@synthesize name, signature, body;

- (id) initWithName: (NSString *)aname
          signature: (ASTNode *)asignature
               body: (ASTNode *)abody
{
    self = [super init];
    if(self)
    {
        self.name = aname;
        self.signature = asignature;
        self.body = abody;
    }
    return self;
}

@end
