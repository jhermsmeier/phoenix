#import <Foundation/Foundation.h>
#import "Types.h"

@class ASTNode;

@interface TupleType: GenericType

@property (nonatomic, retain) NSMutableArray *names;
@property (nonatomic, retain) NSMutableArray *types;
- (id) initWithList: (ASTNode *)list;
- (void) addType: (NSString *)name
                : (GenericType *)type;
- (GenericType *) getTypeForIndex:(int)index;

@end
