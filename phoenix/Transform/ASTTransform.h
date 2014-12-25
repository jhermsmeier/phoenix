//
//  ASTTransform.h
//  phoenix
//
//  Created by Gregory Casamento on 12/25/14.
//  Copyright (c) 2014 indie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASTNode;

@interface ASTTransform : NSObject
{
    ASTNode *originalTree;
    ASTNode *resultantTree;
}

+ (ASTTransform *)createWithAST: (ASTNode *)node
                      forPrefix: (NSString *)prefix;

- (id) initWithAST: (ASTNode *)tree;
- (ASTNode *)resultantTree;
- (ASTNode *)transform;

@end
