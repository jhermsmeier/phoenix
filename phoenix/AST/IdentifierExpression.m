#import "AST.h"

@implementation IdentifierExpression

@synthesize name;

- (id) init: (NSString *)anidentifier
{
    self = [super init];
    if(self)
    {
        self.name = anidentifier;
    }
    return self;
}

- (GenericType *) inferType
{
    return [ctx inferSymbol:self.name];
}

@end
