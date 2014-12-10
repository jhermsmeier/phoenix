#import "ASTNode.h"

@class ExpressionList;

@interface ParenthesizedExpression : ASTNode

@property (nonatomic,retain) ASTNode *expression;
@property (nonatomic,assign) BOOL allowInlineTuple;
- (id) initWithExpression: (ASTNode *)expression;
- (NSString *) toInlineTuple: (ExpressionList *) list;
- (BOOL) isList;
- (NSArray *) toExpressionArray;
- (NSArray *) toTypesArray;
- (NSString *) toTupleInitializer: (NSString *)variableName;
// - (NSString *)toCode;
// - (GenericType *)inferType;

@end
