#import "AST.h"

@implementation LabelStatement

@synthesize labelName, loop;

- (id) initWithLabelName: (NSString *)alabelName
                    loop: (ASTNode *)aloop
{
    self = [super init];
    if(self)
    {
        self.labelName = alabelName;
        self.loop = aloop;
    }
    return self;
}

@end
