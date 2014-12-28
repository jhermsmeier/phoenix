#import "Types.h"

@implementation DictionaryType

@synthesize innerType;

- (id) initWithInnerType: (GenericType *)aninnerType
{
    self = [super initWithType:TYPE_DICTIONARY];
    if(self != nil)
    {
        self.innerType = aninnerType;
    }
    return self;
}
@end
