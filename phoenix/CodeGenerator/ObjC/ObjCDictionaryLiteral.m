#import "ObjCDictionaryLiteral.h"
#import "Functions.h"

@implementation ObjCDictionaryLiteral

- (NSString *)toCode
{
    NSString *result = @"{";
    ASTNode *data = self.pairs;
    if(data)
    {
        NSString *string = tabulate([[data toCode] stringByAppendingString:@"\n"]);
        result = [result stringByAppendingString:string];
    }
    result = [result stringByAppendingString:@"}"];
    return result;
}


@end
