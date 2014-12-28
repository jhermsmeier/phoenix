#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSInteger)toInt
{
    NSError *error = nil;
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:@"[-+]?[0-9]+"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if([regEx matchesInString:self options:NSMatchingAnchored
       range:NSMakeRange(0, [self length])])
    {
        return [self integerValue];
    }
    return NAN;
}

@end
