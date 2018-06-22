//
//  DLogConfig.h
//  DebugLogWindow
//
//  Created by luochaojing on 2018/6/22.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 配置
@interface DLogConfig : NSObject

// 日志保留日期，启动自行清理
// 最大值，最大的条数
// 一个数据类很大的数据类是否影响操作速度
// 数据超过阈值的回调：如果返回了YES，就不处理，如果返回了NO，就处理

@property (assign, nonatomic) NSInteger maxCacheSeconds;
@property (assign, nonatomic) long maxCount;
@property (assign, nonatomic) long maxSize;

@end
