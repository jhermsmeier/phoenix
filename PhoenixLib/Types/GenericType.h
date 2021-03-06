#import <Foundation/Foundation.h>
#import "Types.h"

@class ASTNode;

@interface GenericType : NSObject

@property (nonatomic,assign) SwiftType type;
@property (nonatomic,assign) BOOL optional;
- (id)initWithType: (SwiftType)type;
- (GenericType *) operate: (NSString *)op
                         : (GenericType *)other;
- (NSString *) customBinaryOperator: (ASTNode *)myNode
                                   : (NSString *)op
                                   : (ASTNode *)otherNode;
+ (GenericType *) fromTypeIdentifier: (NSString *)name;
@end
