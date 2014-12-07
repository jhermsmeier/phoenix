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

- (NSString *)toCode
{
    return [[[@"\n" stringByAppendingString: [self.key toCode]]
             stringByAppendingString:@" : "]
            stringByAppendingString:[self.value toCode]];
}

- (GenericType *)inferType
{
    return [self.value getType];
}

@end
