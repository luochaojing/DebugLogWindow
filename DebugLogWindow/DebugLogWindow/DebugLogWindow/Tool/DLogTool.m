//
//  DLogTool.m
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/23.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import "DLogTool.h"

@implementation DLogTool

+ (NSArray *)testSearch:(NSString *)searchStr inMotherStr:(NSString *)motherStr {
    NSMutableArray *rangeArr = @[].mutableCopy;
    NSRange range = [motherStr rangeOfString:searchStr options:NSBackwardsSearch range:NSMakeRange(0, motherStr.length)];
    //循环检索
    while(range.location != NSNotFound)
    {
        NSLog(@"start = %@",NSStringFromRange(range));
        [rangeArr insertObject:[NSValue valueWithRange:range] atIndex:0];
        NSUInteger start = 0;
        NSUInteger end = range.location;
        NSRange temp = NSMakeRange(start,end);
        range = [motherStr rangeOfString:searchStr options:NSBackwardsSearch range:temp];
    }
    return rangeArr.copy;
}

@end
