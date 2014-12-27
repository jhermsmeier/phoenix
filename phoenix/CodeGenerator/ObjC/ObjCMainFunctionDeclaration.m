//
//  ObjCMainFunctionDeclaration.m
//  phoenix
//
//  Created by Gregory Casamento on 12/26/14.
//  Copyright (c) 2014 indie. All rights reserved.
//

#import "ObjCMainFunctionDeclaration.h"
#import "ObjCParenthesizedExpression.h"
#import "ObjCStatementsNode.h"

@implementation ObjCMainFunctionDeclaration

- (id)initWithBody: (ASTNode *)body
{
    // ObjCPar
    // ObjCParenthesizedExpression *signature = [[ObjCParenthesizedExpression alloc] initWithExpression:expr];
    return [self initWithName:@"main" signature:nil body:body];
}

@end
