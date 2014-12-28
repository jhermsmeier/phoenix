#import "AST.h"

@implementation ParenthesizedExpression

@synthesize expression, allowInlineTuple;

- (id) initWithExpression: (ASTNode *)anexpression
{
    self = [super init];
    if(self)
    {
        self.expression = anexpression;
        self.allowInlineTuple = YES;
    }
    return self;
}

- (NSString *) toInlineTuple: (ExpressionList *) list
{
    NSString *result = @"{";
    ExpressionList *item = list;
    int index = 0;
    ExpressionList *validItem = nil;
    ASTNode *expr = nil;
    
    while ((validItem = item) != nil)
    {
        NamedExpression *namedExpression = (NamedExpression *)(AS([validItem current], [NamedExpression class]));
        if (namedExpression)
        {
            NSString *string = [NSString stringWithFormat:@"%@: %@, ",
                                [namedExpression name],
                                [[namedExpression expr] toCode]];
            [result stringByAppendingString:string];
        }
        else if ((expr = [validItem current]) != nil)
        {
            NSString *string = [NSString stringWithFormat:@"%d: %@",index, [expression toCode]];
            result = [result stringByAppendingString:string]; // += "\(index): \(expression.toJS()), ";
        }
        ++index;
        item = validItem.next;
    }
    
    result = [result substringToIndex: [result lengthOfBytesUsingEncoding:NSUTF8StringEncoding] - 2]; //remove last ', '
    result = [result stringByAppendingString:@"}"];
    
    return result;
}

- (BOOL) isList
{
    ExpressionList *list = (ExpressionList *)(AS(self.expression,
                                                 [ExpressionList class]));
    if(list)
    {
        if([list next])
        {
            return YES;
        }
    }
    return NO;
}

- (NSArray *) toExpressionArray
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:10];
    ExpressionList *node = (ExpressionList *)(AS(self.expression, [ExpressionList class]));
    ExpressionList *item = nil;
    
    while((item = node) != nil)
    {
        [result addObject:[item current]];
        node = [item next];
    }
    
    return (NSArray *)result;
}

- (NSArray *) toTypesArray
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:10];
    ExpressionList *node = (ExpressionList *)(AS(self.expression, [ExpressionList class]));
    ExpressionList *item = nil;
    
    while((item = node) != nil)
    {
        [result addObject:[[item current] getType]];
        node = [item next];
    }
    
    return (NSArray *)result;
}

- (NSString *) toTupleInitializer: (NSString *)variableName
{
    ExpressionList *list = (ExpressionList *)(AS(self.expression, [ExpressionList class]));
    NSString *result = [variableName stringByAppendingString: @" = "];
    result = [result stringByAppendingString:[NSString stringWithFormat:@"%@ = %@", variableName, [self toInlineTuple: list]]];
    return result;
}

- (GenericType *)inferType
{
    if (self.allowInlineTuple)
    {
        ExpressionList *list = (ExpressionList *)(AS(self.expression, [ExpressionList class]));
        ASTNode *item = nil;
        if(list != nil)
        {
            if( [list next] )
            {
                //mutiple elements = > tuple
                return [[TupleType alloc] initWithList:list];
            }
            else if ((item = [list current]) != nil)
            {
                //single element => not a tuple
                return [item getType];
            }
        }
    }
    
    ASTNode *expr = nil;
    if ((expr = (ASTNode *)self.expression) != nil)
    {
        return [expr getType];
    }
    
    return nil;
}

@end
