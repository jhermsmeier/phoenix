#import "ObjCFunctionParameter.h"

@implementation ObjCFunctionParameter

- (NSString *)toCode
{
    return self.local ? self.local : self.external;
}

@end
