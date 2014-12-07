#import "Types.h"

@implementation GenericType

@synthesize type;

- (id)initWithType: (SwiftType)aType
{
    self = [super init];
    if(self != nil)
    {
        self.type = aType;
    }
    return self;
}

- (GenericType *) operate: (NSString *)op
                         : (GenericType *)other
{
    if( [op isEqualToString: @"==="]
        || [op isEqualToString: @"=="]
        || [op isEqualToString: @"&&"]
        || [op isEqualToString: @"||"] )
    {
        return [[GenericType alloc] initWithType:TYPE_BOOLEAN];
    }
    else if( [op isEqualToString: @"="] )
    {
        return other;
    }
    else if (self.type == TYPE_STRING || other.type == TYPE_STRING)
    {
        return [[GenericType alloc] initWithType: TYPE_STRING];
    }
    else
    {
        return self;
    }
}

- (NSString *) customBinaryOperator: (ASTNode *)myNode
                                   : (NSString *)op
                                   : (ASTNode *)otherNode
{
    return nil;
}

+ (GenericType *) fromTypeIdentifier: (NSString *)name
{
    if ([name isEqualToString: @"String"])
    {
        return [[GenericType alloc] initWithType:TYPE_STRING];
    }
    else if ([name isEqualToString: @"Int"])
    {
        return [[GenericType alloc] initWithType:TYPE_NUMBER];
    }
    else
    {
        return [[GenericType alloc] initWithType:TYPE_UNKNOWN];
    }
}

@end
