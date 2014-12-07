#import "GenericType.h"

@interface DictionaryType: GenericType
@property (nonatomic, retain) GenericType *innerType;
- (id) initWithInnerType: (GenericType *)innerType;
@end
