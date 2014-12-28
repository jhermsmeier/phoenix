//
//  ObjCASTTransform.m
//  phoenix
//
//  Created by Gregory Casamento on 12/25/14.
//  Copyright (c) 2014 indie. All rights reserved.
//

#import "ObjCASTTransform.h"
#import "ObjCStatementsNode.h"
#import "ObjCStatementNode.h"
#import "ObjCMainFunctionDeclaration.h"

@implementation ObjCASTTransform

- (ASTNode *)transform
{
    [super transform];
    ObjCMainFunctionDeclaration *main = [[ObjCMainFunctionDeclaration alloc] init];
    
    ObjCStatementsNode *item = (ObjCStatementsNode *)resultantTree;
    // ObjCStatementsNode *item = (ObjCStatementsNode *)[root next];
    ObjCStatementsNode *valid = nil;
    while ((valid = item) != nil)
    {
        ObjCStatementNode *current = (ObjCStatementNode *)[valid current];
        ASTNode *func = [current statement];
        NSLog(@"NODE: %@",func);
        item = (ObjCStatementsNode *)[valid next];
    }
    return resultantTree;
}

@end
