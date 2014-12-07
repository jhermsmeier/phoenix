#import "Types.h"
#import "NamedExpression.h"
#import "ExpressionList.h"

@implementation TupleType

@synthesize names, types;

- (id) initWithList: (ExpressionList *)list
{
    self = [super initWithType: TYPE_TUPLE];
    if(self != nil)
    {
        ExpressionList *item = list;
        int index = 0;
        id validItem = nil;
        
        self.names = [[NSMutableArray alloc] initWithCapacity:10];
        self.types = [[NSMutableArray alloc] initWithCapacity:10];
        
        while((validItem = item) != nil)
        {
            NamedExpression *namedExpression = nil;
            NamedExpression *expression = nil;
            ExpressionList *vItem = (ExpressionList *)validItem;
            if ((namedExpression = (NamedExpression *)[vItem current]) != nil)
            {
                [self addType: namedExpression.name
                             : namedExpression.type];
            }
            else if((expression = (NamedExpression *)[vItem current]) != nil)
            {
                NSString *str = [NSString stringWithFormat:@"%d",index];
                [self addType: str
                             : expression.type];
            }
            ++index;
            item = [vItem next];
        }
    }
    return self;
}

- (void) addType: (NSString *)name
                : (GenericType *)type
{
    [self.names addObject:name];
    [self.types addObject:type];
}

- (GenericType *) getTypeForIndex:(int)index
{
    return (GenericType *)[self.types objectAtIndex:index];
}
@end
