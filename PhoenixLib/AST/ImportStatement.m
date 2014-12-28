#import "AST.h"

@implementation ImportStatement

@synthesize path;

- (id) initWithPath: (NSString *)apath
{
    self = [super init];
    if(self)
    {
        self.path = apath;
    }
    return self;
}

@end
