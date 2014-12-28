#import "ASTNode.h"

@interface FunctionParameter : ASTNode
@property (nonatomic, assign) BOOL inoutVal;
@property (nonatomic, assign) BOOL letVal;
@property (nonatomic, assign) BOOL hashVal;
@property (nonatomic, retain) NSString *external;
@property (nonatomic, retain) NSString *local;
@property (nonatomic, retain) ASTNode *defVal;

- (id) initWithInoutVal: (BOOL)inoutVal
                 letVal: (BOOL)letVal
                hashVal: (BOOL)hashVal
               external: (NSString *)external
                  local: (NSString *)local
                 defVal: (ASTNode *)defVal;

// - (NSString *)toCode;
// - (GenericType *)inferType;
@end
