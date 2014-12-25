//
//  Compiler.m
//  phoenix
//
//  Created by Gregory Casamento on 12/25/14.
//  Copyright (c) 2014 indie. All rights reserved.
//

#import "Compiler.h"
#import "Lexer.h"
#import "AST.h"
#import "bridge.h"

@implementation Compiler

- (id)initWithSourceCode:(NSString *)code andPrefix:(NSString *)pfx
{
    self = [super init];
    if(self != nil)
    {
        sourceCode = code;
        [sourceCode retain];
        prefix = pfx;
        [prefix retain];
        [ASTNode setPrefix:prefix];
    }
    return self;
}

- (id)initWithContentsOfFile:(NSString *)filename
                   andPrefix:(NSString *)pfx
{
    NSError *error = nil;
    NSString *code = [NSString stringWithContentsOfFile:filename
                                               encoding:NSUTF8StringEncoding
                                                  error:&error];
    id obj = nil;
    if(code)
    {
        obj = [self initWithSourceCode:code andPrefix:pfx];
    }
    return obj;
}

- (void)compile
{
    BOOL debug = NO;
    Lexer *lexer = [[Lexer alloc] initWithSourceCode:sourceCode];
    
    if(debug)
    {
        NSLog(@"Lexer Tokens");
        NSLog(@"============");
        [lexer debugTokens];
        NSLog(@"============\n");
        
        
        NSLog(@"AST Parser");
        NSLog(@"===========");
    }
    
    rootNode = (ASTNode *)bridge_yyparse(lexer, debug);
    if(rootNode != nil)
    {
        transform = [ASTTransform createWithAST:rootNode
                                      forPrefix:prefix];
        transformed = [transform transform];
        NSString *program = [transformed toCode];
        NSString *error = nil;
        const char *errstr = bridge_yyerror();
        
        if(errstr != NULL)
        {
            error = [NSString stringWithUTF8String:errstr];
        }
        
        output = program;
        [output retain];
        
        errors = error;
        [errors retain];
    }
}

- (id)output
{
    return output;
}

- (NSString *)errors
{
    return errors;
}

@end
