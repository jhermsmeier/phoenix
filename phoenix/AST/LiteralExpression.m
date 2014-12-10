#import "AST.h"

@implementation LiteralExpression

@synthesize value;

- (id) init: (NSString *)aliteral
{
    self = [super init];
    if(self)
    {
        self.value = aliteral;
    }
    return self;
}

- (GenericType *) inferType
{
    if ([self.value isEqualToString: @"true"] ||
        [self.value isEqualToString: @"false"])
    {
        return [[GenericType alloc] initWithType:TYPE_BOOLEAN];
    }
    else if ([self.value hasPrefix: @"\""])
    {
        return [[GenericType alloc] initWithType:TYPE_STRING];
    }
    else {
        return [[GenericType alloc] initWithType:TYPE_NUMBER];
    }
}

@end
