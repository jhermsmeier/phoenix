//
//  main.m
//  phoenix
//
//  Created by Gregory Casamento on 10/29/14.
//  Copyright (c) 2014 indie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Compiler.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        /*
        if(argc <= 1)
        {
            puts("No input files");
            return 0;
        }
         */
        ctx = [[ASTContext alloc] init];
        NSString *fileName = nil;
        // fileName = @"/tmp/webkit.swift";
        fileName = @"/tmp/hello.swift";
        // fileName = [NSString stringWithUTF8String:argv[1]];
        NSString *sourceCode = [NSString stringWithContentsOfFile:fileName
                                                         encoding:NSUTF8StringEncoding
                                                            error:NULL];
        
        NSString *imports = @"import Foundation\nimport AppKit\n";
        sourceCode = [imports stringByAppendingString:sourceCode];
        
        Compiler *compiler = [[Compiler alloc] initWithSourceCode:sourceCode
                                                        andPrefix:@"ObjC"];
        [compiler compile];
        
        NSString *outputCode = [compiler output];
        NSString *error = [compiler errors];
        
        NSLog(@"Code Output:\n===\n%@",outputCode);
        NSLog(@"Errors:\n===\n%@",error);

    }
    return 0;
}
