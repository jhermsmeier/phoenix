#import <Foundation/Foundation.h>
#import "GenericType.h"

@interface IndirectionType : GenericType
@property (nonatomic, retain) GenericType *pointer;
- (id) initWithPointer: (GenericType *)pointer;
- (void) update: (GenericType *)pointer;
@end
