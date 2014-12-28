#import "ObjCIdentifierExpression.h"

@implementation ObjCIdentifierExpression

- (NSString *) toCode
{
    return self.name;
}

@end
