#import <Foundation/Foundation.h>
#import "Types.h"

#define AS(X,Y) ([[X class] isKindOfClass: Y])?X:nil
#define ASTSymbolTable NSMutableDictionary

@interface ASTNode: NSObject
{
    GenericType *type;
}

@property (nonatomic, retain) GenericType *type;

+ (NSString *)prefix;
+ (void)setPrefix:(NSString *)string;

- (NSString *)toCode;
- (GenericType *) getType;
- (GenericType *) inferType;
- (void) setType: (GenericType *)type;
- (void) setTypeIfEmpty: (GenericType *)type;

@end
