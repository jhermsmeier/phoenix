#import "Types.h"

@implementation IndirectionType

@synthesize pointer;

- (id) initWithPointer: (GenericType *)apointer
{
    self = [super initWithType: apointer.type];
    if(self != nil)
    {
        self.pointer = apointer;
    }
    return self;
}

- (void) update: (GenericType *)pointer
{
    
}
@end
