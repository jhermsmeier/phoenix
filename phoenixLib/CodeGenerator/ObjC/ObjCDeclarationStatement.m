#import "ObjCDeclarationStatement.h"
#import "VariableDeclaration.h"

@implementation ObjCDeclarationStatement

- (NSString *)toCode
{
    VariableDeclaration *varDeclaration = (VariableDeclaration *)(AS(self.declaration, [VariableDeclaration class]));
    if(varDeclaration)
    {
        varDeclaration.exportVariables = NO;
    }
    return [self.declaration toCode];
}

@end
