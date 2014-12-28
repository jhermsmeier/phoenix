#import "AST.h"

@implementation BreakStatement

@synthesize labelName;

- (id) initWithLabelId: (NSString *)alabelName
{
    self = [super init];
    if(self)
    {
        self.labelName = alabelName;
    }
    return self;
}

@end
