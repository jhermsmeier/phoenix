#import "ObjCFunctionDeclaration.h"
#import "Functions.h"

@implementation ObjCFunctionDeclaration

- (NSString *)toCode
{
    NSString *result = [NSString stringWithFormat:@"%@ (", self.name];
    ASTNode *parameters = self.signature;
    if (parameters)
    {
        result = [result stringByAppendingString:[parameters toCode]];
    }
    result = [result stringByAppendingString:@") {\n"];

    ASTNode *statements = self.body;
    if(statements)
    {
        NSString *string = tabulate([statements toCode]);
        result = [result stringByAppendingString:string];
    }

    result = [result stringByAppendingString: @"}"];
    return result;
}

@end
