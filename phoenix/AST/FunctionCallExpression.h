#import "ASTNode.h"

@class ParenthesizedExpression;

@interface FunctionCallExpression : ASTNode

@property (nonatomic, retain) ASTNode *function;
@property (nonatomic, retain) ParenthesizedExpression *parenthesized;

- (id) initWithFunction: (ASTNode *)function
          parenthesized: (ParenthesizedExpression *)parenthesized;

// - (NSString *)toCode;
// - (GenericType *)inferType;
@end
