//
//  DLogDBTable.h
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/22.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DlogModel;
@class FMDatabase;

@interface DLogDBTable : NSObject

/// 是否需要数据库呢
+ (void)insertLogModel:(DlogModel *)logModel toDb:(FMDatabase *)db;
+ (void)insertLogModelArr:(NSArray<DlogModel *> *)logModelArr toDb:(FMDatabase *)db;
+ (BOOL)createLogTableInDb:(FMDatabase *)db;
+ (NSArray<DlogModel *> *)searchLogmodelsWithKeyWords:(NSArray<NSString *> *)keywords option:(NSString *)option inDb:(FMDatabase *)db;
@end
