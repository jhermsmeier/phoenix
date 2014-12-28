#import "ASTNode.h"

@interface DictionaryLiteral : ASTNode

@property (nonatomic, retain) ASTNode *pairs;

- (id) initWithPairs: (ASTNode *)pairs;
// - (NSString *)toCode;
// - (GenericType *)inferType;
@end
