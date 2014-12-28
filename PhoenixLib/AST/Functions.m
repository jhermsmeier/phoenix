//
//  phoenix
//
//  Created by Gregory Casamento on 10/29/14.
//  Copyright (c) 2014 indie. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *tabulate(NSString *code)
{
    NSRange range = NSMakeRange(0, [code lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
    NSString *result = [code stringByReplacingOccurrencesOfString:@"\n"
                                                       withString:@"\n\t"
                                                          options: NSCaseInsensitiveSearch
                                                            range: range];
    
    if( [result hasSuffix:@"\t"] )
    {
        result = [result substringToIndex:
                  [result lengthOfBytesUsingEncoding:NSUTF8StringEncoding] - 1];
    }
    result = [@"\t" stringByAppendingString: result];
    return result;
}
