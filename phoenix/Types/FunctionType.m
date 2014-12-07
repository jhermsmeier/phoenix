#import "Types.h"

@implementation FunctionType

@synthesize argumentTypes, returnType;

- (id) initWithArgumentTypes: (NSMutableArray *)anargumentTypes
                  returnType: (GenericType *)areturnType
{
    if((self = [super initWithType:TYPE_DICTIONARY]) != nil)
    {
        self.argumentTypes = [anargumentTypes copy];
        self.returnType = areturnType;
    }
    return self;
}

- (id) initWithArgsType:(GenericType *)anargsType
             returnType:(GenericType *)areturnType
{
    self = [super initWithType:TYPE_DICTIONARY];
    
    if(self)
    {
        TupleType *tuple = nil;
        if([anargsType isKindOfClass:[TupleType class]])
        {
            tuple = (TupleType *)anargsType;
        }
        
        if(tuple != nil)
        {
            [self.argumentTypes addObjectsFromArray:tuple.types];
        }
        
        self.returnType = areturnType;
    }
    
    return self;
}
@end
