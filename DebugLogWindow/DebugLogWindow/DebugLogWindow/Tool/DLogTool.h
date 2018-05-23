//
//  DLogTool.h
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/23.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 通用工具
@interface DLogTool : NSObject

/// NSValue with NSRange
+ (NSArray *)testSearch:(NSString *)searchStr inMotherStr:(NSString *)motherStr;

@end
