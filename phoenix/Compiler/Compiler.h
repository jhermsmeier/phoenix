//
//  Compiler.h
//  phoenix
//
//  Created by Gregory Casamento on 12/25/14.
//  Copyright (c) 2014 indie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AST.h"

@interface Compiler : NSObject
{
    ASTNode *rootNode;
    NSString *sourceCode;
    NSString *errors;
    NSString *prefix;
    id output;
}

- (id)initWithSourceCode:(NSString *)code andPrefix:(NSString *)prefix;
- (id)initWithContentsOfFile:(NSString *)filename
                   andPrefix:(NSString *)prefix;
- (void)compile;
- (id)output;
- (NSString *)errors;

@end
