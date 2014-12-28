#import "ASTNode.h"

@class ParenthesizedExpression;

@interface BinaryExpression: ASTNode
@property (nonatomic, retain) ASTNode *current;
@property (nonatomic, retain) BinaryExpression *next;
- (id) initWithExpression: (ASTNode *)expression;
- (id) initWithExpression: (ASTNode *)expression
                     next: (BinaryExpression *)next;
- (NSString *) leftAndRightTypeToCodeLeft: (ParenthesizedExpression *)left
                                    right: (ParenthesizedExpression *)right;
- (NSString *) leftTupleAndRightExpressionToCodeLeft: (ParenthesizedExpression *)left
                                               right: (ASTNode *)right;
// - (NSString *)toCode;
// - (GenericType *)inferType;
@end
