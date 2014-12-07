#import "AST.h"

@implementation FunctionDeclaration

@synthesize name, signature, body;

- (id) initWithName: (NSString *)aname
          signature: (ASTNode *)asignature
               body: (ASTNode *)abody
{
    self = [super init];
    if(self)
    {
        self.name = aname;
        self.signature = asignature;
        self.body = abody;
    }
    return self;
}

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
