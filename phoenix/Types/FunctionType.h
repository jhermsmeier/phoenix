#import <Foundation/Foundation.h>
#import "GenericType.h"

@interface FunctionType: GenericType
@property (nonatomic, retain) GenericType *returnType;
@property (nonatomic, retain) NSMutableArray *argumentTypes;
- (id) initWithArgumentTypes: (NSMutableArray *)argumentTypes
                  returnType: (GenericType *)returnType;
- (id) initWithArgsType:(GenericType *)argsType
             returnType:(GenericType *)returnType;
@end
