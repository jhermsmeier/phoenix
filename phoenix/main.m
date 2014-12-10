//
//  main.m
//  phoenix
//
//  Created by Gregory Casamento on 10/29/14.
//  Copyright (c) 2014 indie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lexer.h"
#import "AST.h"
#import "bridge.h"

// ASTNode* bridge_yyparse(Lexer * lexer, int debug);
// const char * bridge_yyerror();

NSDictionary *swiftCompiler(NSString *sourceCode, BOOL debug)
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
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
    
    ASTNode *ast = (ASTNode *)bridge_yyparse(lexer, debug);
    if(ast != nil)
    {
        NSString *program = [ast toCode];
        NSString *error = nil;
        const char *errstr = bridge_yyerror();

        if(errstr != NULL)
        {
            error = [NSString stringWithUTF8String:errstr];
            [result setObject:error forKey:@"error"];
        }
        
        [result setObject:program forKey:@"program"];
    }
    
    return result;
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        BOOL debug = NO;
        [ASTNode setPrefix:@"ObjC"];
        
        /*
        if(argc <= 1)
        {
            puts("No input files");
            return 0;
        }
         */
        ctx = [[ASTContext alloc] init];
        NSString *fileName = @"/tmp/webkit.swift";
        fileName = @"/tmp/hello.swift";
        // NSString *fileName = [NSString stringWithUTF8String:argv[1]];
        NSString *sourceCode = [NSString stringWithContentsOfFile:fileName
                                                         encoding:NSUTF8StringEncoding
                                                            error:NULL];
        
        NSString *imports = @"import Foundation\nimport AppKit\n";
        sourceCode = [imports stringByAppendingString:sourceCode];
        
        NSDictionary *result = swiftCompiler(sourceCode, debug);
        
        NSString *outputCode = [result objectForKey:@"program"];
        NSString *error = [result objectForKey:@"error"];
        
        NSLog(@"Code Output:\n===\n%@",outputCode);
        NSLog(@"Errors:\n===\n%@",error);

    }
    return 0;
}
