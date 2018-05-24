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


+ (NSNumber *)timestampWithDate:(NSDate *)date {
    if (!date) {
        return @0.0;
    }
    NSInteger t = [date timeIntervalSince1970] * 1000;
    return @(t);
}

+ (NSDate *)dateWithTimestampNum:(NSNumber *)timestampNum {
    if (!timestampNum) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:timestampNum.doubleValue / 1000.0];
}

@end
