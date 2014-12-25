
//
//  ASTTransform.m
//  phoenix
//
//  Created by Gregory Casamento on 12/25/14.
//  Copyright (c) 2014 indie. All rights reserved.
//

#import "ASTTransform.h"
#import "ASTNode.h"
@implementation ASTTransform

+ (ASTTransform *)createWithAST: (ASTNode *)node
                      forPrefix: (NSString *)prefix
{
    NSString *className = [prefix stringByAppendingString:@"ASTTransform"];
    Class clz = NSClassFromString(className);
    ASTTransform *transform = [[clz alloc] initWithAST:node];
    return transform;
}

- (id)initWithAST:(ASTNode *)tree
{
    self = [super init];
    if(self)
    {
        originalTree = tree;
        [originalTree retain];
    }
    return self;
}

- (ASTNode *)resultantTree
{
    return resultantTree;
}

- (ASTNode *) transform
{
    resultantTree = originalTree;
    [resultantTree retain];
    return resultantTree;
}

@end
