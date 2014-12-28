#import "ASTNode.h"

@interface DictionaryItem: ASTNode

@property (nonatomic, retain) ASTNode *key;
@property (nonatomic, retain) ASTNode *value;

- (id) initWithKey: (ASTNode *)key value: (ASTNode *)value;
// - (NSString *)toCode;
// - (GenericType *)inferType;
@end
