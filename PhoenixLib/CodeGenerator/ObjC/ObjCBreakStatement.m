#import "ObjCBreakStatement.h"

@implementation ObjCBreakStatement

- (NSString *)toCode
{
    NSString *identifier = self.labelName;
    if(identifier)
    {
        return [NSString stringWithFormat:@"break %@;",identifier];
    }
    return @"break;";
}

@end
