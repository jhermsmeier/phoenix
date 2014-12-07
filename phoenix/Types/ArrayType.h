#import "GenericType.h"

@interface ArrayType : GenericType
@property (nonatomic, retain) GenericType *innerType;
- (id) initWithInnerType: (GenericType *)innerType;
@end
