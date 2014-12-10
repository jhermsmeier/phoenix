#import "ObjCImportStatement.h"

@implementation ObjCImportStatement

- (NSString *)toCode
{
    NSString *pathRep = [NSString stringWithFormat:@"%@/%@.h",self.path, self.path];
    return [NSString stringWithFormat:@"#import <%@>\n",pathRep];
}

@end
