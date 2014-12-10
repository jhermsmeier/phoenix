#import "ObjCLabelStatement.h"

@implementation ObjCLabelStatement

- (NSString *)toCode
{
    return [NSString stringWithFormat:@"%@:\n%@",self.labelName,
            [self.loop toCode]];
}

@end
