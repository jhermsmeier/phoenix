#import "AST.h"

@implementation StatementsNode

@synthesize current;

- (id) initWithCurrent: (ASTNode *)acurrent
{
    self = [super init];
    if(self)
    {
        self.current = acurrent;
    }
    return self;
}

- (id) initWithCurrent: (ASTNode *)acurrent
                  next: (StatementsNode *)anext
{
    self = [super init];
    if(self)
    {
        self.current = acurrent;
        self.next = anext;
    }
    return self;
}

- (NSInteger) getStatementsCount
{
    int result = 1;
    StatementsNode *item = (StatementsNode *)self.next;
    StatementsNode *valid = nil;
    while ( (valid = item) != nil)
    {
        result++;
        item = (StatementsNode *)[valid next];
    }
    return result;
}
@end
