//
//  DLogDataBaseMgr.h
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/22.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@class DlogModel;

@interface DLogDataBaseMgr : NSObject

+ (DLogDataBaseMgr *)shared;

- (void)addLogModel:(DlogModel *)logModel;
- (void)searchLogmodelsWithKeyWords:(NSArray<NSString *> *)keywords option:(NSString *)option then:(void (^)(NSArray<DlogModel *> *))then;

- (void)addLogModelArr:(NSArray<DlogModel *> *)logModelArr;

- (long long)currentDbSize;
@end
