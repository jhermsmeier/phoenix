#import "AST.h"

static NSString *ASTNode_prefix = nil;

@implementation ASTNode

@dynamic type;

/* Part of code generation integration... */

/**
 * Prefix returns the prefix used by the Code Generation classes
 * so that they can be intstantiated.
 */
+ (NSString *) prefix
{
    if(ASTNode_prefix == nil)
    {
        return @"";
    }
    
    return ASTNode_prefix;
}

+ (void) setPrefix: (NSString *)string
{
    ASTNode_prefix = string;
    [ASTNode_prefix retain];
}

/** 
 * Override alloc: so that the proper instance is returned.
 */
+ (instancetype)alloc
{
    if(self != [ASTNode class])
    {
        NSString *className = [NSString stringWithFormat:@"%@%@",[self prefix],NSStringFromClass(self)];
        Class clz = NSClassFromString(className);
        return [clz allocWithZone:NSDefaultMallocZone()];
    }
    return [super alloc];
}

- (id) init
{
    self = [super init];
    if(self)
    {
        type = nil;
        [self retain];
    }
    return self;
}

- (NSString *)toCode
{
    return nil;
}

- (GenericType *) getType
{
    GenericType *cached = type;
    if(cached)
    {
        return cached;
    }
    type = [self inferType];
    return type ? type : [[GenericType alloc] initWithType:TYPE_UNKNOWN];
}

- (GenericType *) inferType
{
    return nil;
}

- (void) setType: (GenericType *)atype
{
    type = atype;
    [type retain];
}

- (void) setTypeIfEmpty: (GenericType *)atype
{
    if(self.type == nil)
    {
        type = atype;
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ : %@",[super description],[self toCode]];
}

@end
