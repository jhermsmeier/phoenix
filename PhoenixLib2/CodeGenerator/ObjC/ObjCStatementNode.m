#import "ObjCStatementNode.h"

@implementation ObjCStatementNode

- (NSString *)toCode
{
    return [NSString stringWithFormat:@"%@;",[self.statement toCode]];
}

@end
