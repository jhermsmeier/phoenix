#import "ObjCDictionaryItem.h"

@implementation ObjCDictionaryItem

@synthesize key, value;

- (NSString *)toCode
{
    return [[[@"\n" stringByAppendingString: [self.key toCode]]
             stringByAppendingString:@" : "]
            stringByAppendingString:[self.value toCode]];
}

@end
