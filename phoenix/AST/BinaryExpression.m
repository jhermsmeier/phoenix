#import "AST.h"

@implementation BinaryExpression

@synthesize current;

- (id) initWithExpression: (ASTNode *)anexpression
{
    self = [super init];
    if(self)
    {
        self.current = anexpression;
    }
    return self;
}

- (id) initWithExpression: (ASTNode *)anexpression
                     next: (BinaryExpression *)anext
{
    self = [super init];
    if(self)
    {
        self.current = anexpression;
        self.next = anext;
    }
    return self;
}

- (NSString *) leftAndRightTypeToCodeLeft: (ParenthesizedExpression *)left
                              right: (ParenthesizedExpression *)right
{
    NSString *result = @"";
    NSArray *names = [left toExpressionArray];
    NSArray *values = [right toExpressionArray];
    NSUInteger i = 0;
    for (i = 0; i < [names count]; ++i)
    {
        if (i >= [values count])
        {
            break;
        }
        
        [names[i] setTypeIfEmpty:[[values objectAtIndex:i] getType]]; //infere type from assignment if needed
        NSString *string = [NSString stringWithFormat:@"((%@) = (%@)), ",[[names objectAtIndex:i] toCode], [[values objectAtIndex:i]  toCode]];
        result = [result stringByAppendingString:string];
    }
    result = [result substringToIndex: [result lengthOfBytesUsingEncoding:NSUTF8StringEncoding] - 2];
    return result;
}

- (NSString *) leftTupleAndRightExpressionToCodeLeft: (ParenthesizedExpression *)left
                                               right: (ASTNode *)right
{
    NSString *tupleID = @"";
    LiteralExpression *literal = nil;
    IdentifierExpression *identifier = nil;
    if((literal = (LiteralExpression *)right) != nil)
    {
        tupleID = [literal toCode];
    }
    else if ((identifier = (IdentifierExpression *)right) != nil)
    {
        tupleID = [identifier toCode];
    }
    else
    {
        NSString *varName = [NSString stringWithFormat: @"%@ = %@", tupleID,
                             [right toCode]];
        tupleID = [ctx generateID];
        [ctx exportVar: varName];
    }
    
    NSArray *names = [left toExpressionArray];
    NSString *result = @"";
    TupleType *tupleType = nil;
    
    if ((tupleType = (TupleType *)[right getType]) != nil)
    {
        //known tuple type
        NSArray *tupleMembers = [tupleType names];
        int i = 0;
        for ( i = 0; i < [names count]; ++i )
        {
            [names[i] setTypeIfEmpty: [tupleType getTypeForIndex: i]]; //infere type from assignment if needed
            NSInteger number = [tupleMembers[i] toInt];
            if(isnan(number) == NO)
            {
                NSString *string = [NSString stringWithFormat:@"%@ = %@[%ld]",[[names objectAtIndex:i]  toCode], tupleID, (long)number];
                result = [result stringByAppendingString:string];
            }
            else
            {
                NSString *string = [NSString stringWithFormat:@"%@ = %@[%@]",[[names objectAtIndex:i]  toCode], tupleID, [tupleMembers objectAtIndex:i]];
                result = [result stringByAppendingString:string];
            }
        }
    }
    else {
        //unkown tuple type
        NSInteger i = 0;
        for (i = 0; i < names.count; ++i)
        {
            NSString *string = [NSString stringWithFormat:@"%@ = %@[Object.keys(%@)[%ld], ", [[names objectAtIndex:i] toCode], tupleID, tupleID, i];
            result = [result stringByAppendingString:string];
        }
    }
    
    result = [result substringToIndex: [result lengthOfBytesUsingEncoding:NSUTF8StringEncoding] - 2];
    return result;
}

- (GenericType *)inferType
{
    if([self current])
    {
        return nil;
    }
    
    GenericType *leftType = [self.current getType];
    if([[self.next current] class] == [BinaryOperator class])
    {
        BinaryOperator *op = (BinaryOperator *)[self.next current];
        return [leftType operate:[op binaryOperator]
                                :[op getType]];
    }
    else if([[self.next current] class] == [AssignmentOperator class])
    {
        AssignmentOperator *op = (AssignmentOperator *)[self.next current];
        self.current.type = [op getType];
        return [op getType];
    }
    
    return leftType;
}

@end
