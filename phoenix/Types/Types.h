//
//  Types.h
//
//  Created by Gregory Casamento on 10/20/14.
//

#import <Foundation/Foundation.h>

@class ASTNode;
@class ExpressionList;

enum {
    TYPE_STRING = 1,
    TYPE_BOOLEAN, TYPE_NUMBER, TYPE_ARRAY, TYPE_DICTIONARY,
    TYPE_TUPLE,
    TYPE_FUNCTION,
    TYPE_CLASS,
    TYPE_STRUCT,
    TYPE_VOID,
    TYPE_UNKNOWN
};
typedef NSUInteger SwiftType;

#import "ArrayType.h"
#import "DictionaryType.h"
#import "FunctionType.h"
#import "GenericType.h"
#import "IndirectionType.h"
#import "TupleType.h"