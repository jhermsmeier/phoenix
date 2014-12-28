#import "ObjCBinaryExpression.h"
#import "ParenthesizedExpression.h"
#import "LiteralExpression.h"
#import "IdentifierExpression.h"
#import "ASTContext.h"
#import "TupleType.h"
#import "AssignmentOperator.h"
#import "BinaryOperator.h"
#import "NSString+Extension.h"

@implementation ObjCBinaryExpression

- (NSString *)toCode
{
    //Check Tuple assignment binary expressions
    AssignmentOperator *assignment = (AssignmentOperator *)(AS([self.next current],[AssignmentOperator class]));
    if (assignment != nil)
    {
        self.current.type = [assignment.rightOperand getType];
        //check left to right tuple assignment
        ParenthesizedExpression *leftTuple =  (ParenthesizedExpression *)(AS([self current], [ParenthesizedExpression class]));
        ParenthesizedExpression *rightTuple = (ParenthesizedExpression *)(AS(assignment.rightOperand, [ParenthesizedExpression class]));
        
        if(leftTuple && [leftTuple isList] && rightTuple && [rightTuple isList])
        {
            return [self leftAndRightTypeToCodeLeft:leftTuple
                                              right:rightTuple];
        }
        else if(leftTuple && [leftTuple isList])
        {
            return  [self leftTupleAndRightExpressionToCodeLeft:leftTuple
                                                          right:assignment.rightOperand];
        }
    }
    
    BinaryOperator *binaryOperator = (BinaryOperator *)(AS([self.next current],[BinaryOperator class]));
    //check for custom operators. Example array +=
    if(binaryOperator)
    {
        NSString *customOperator = [[self.current getType]
                                    customBinaryOperator:self.current
                                    :binaryOperator.binaryOperator
                                    :binaryOperator.rightOperand];
        return customOperator;
    }

    //Generic binary expression
    NSString *result = @"";
    id currentExpression = self.current;
    id nextExpression = self.next;
    if(currentExpression)
    {
        result = [result stringByAppendingString: [currentExpression toCode]];
    }
    if(nextExpression)
    {
        result = [result stringByAppendingString: [nextExpression toCode]];
    }

    return result;
}

@end
