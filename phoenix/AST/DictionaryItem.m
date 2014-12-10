#import "AST.h"

@implementation DictionaryItem

@synthesize key, value;

- (id) initWithKey: (ASTNode *)akey value: (ASTNode *)avalue
{
    self = [super init];
    if(self)
    {
        self.key = akey;
        self.value = avalue;
    }
    return self;
}

- (GenericType *)inferType
{
    return [self.value getType];
}

@end
