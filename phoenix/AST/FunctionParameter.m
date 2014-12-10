#import "AST.h"

@implementation FunctionParameter

@synthesize inoutVal, letVal, hashVal, external, local, defVal;

- (id) initWithInoutVal: (BOOL)aninoutVal
                 letVal: (BOOL)aletVal
                hashVal: (BOOL)ahashVal
               external: (NSString *)anexternal
                  local: (NSString *)alocal
                 defVal: (ASTNode *)adefVal
{
    self = [super init];
    if(self)
    {
        self.inoutVal = aninoutVal;
        self.letVal = aletVal;
        self.hashVal = ahashVal;
        self.external = anexternal;
        self.local = alocal;
        self.defVal = adefVal;
    }
    return self;
}

@end
