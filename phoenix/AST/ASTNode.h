#import <Foundation/Foundation.h>

@interface ASTNode: NSObject
{
    GenericType *type;
}

@property (nonatomic, retain) GenericType *type;

- (NSString *)toCode;
- (GenericType *) getType;
- (GenericType *) inferType;
- (void) setType: (GenericType *)type;
- (void) setTypeIfEmpty: (GenericType *)type;

@end
