#import "ObjCArrayLiteral.h"

@implementation ObjCArrayLiteral

- (NSString *)toCode
{
    NSString *result = @"@[";
    ASTNode *data = self.items;
    if(data != nil)
    {
        result = [result stringByAppendingString:[data toCode]];
    }
    result = [result stringByAppendingString:@"]"];
    return result;
}

@end
