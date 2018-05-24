//
//  DLogDBTable.m
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/22.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import "DLogDBTable.h"
#import <FMDB.h>
#import "DlogModel.h"
#import "DLogTool.h"

@implementation DLogDBTable

+ (BOOL)createLogTableInDb:(FMDatabase *)db {
    BOOL createLogTable = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS debug_logs_table (log_id integer PRIMARY KEY AUTOINCREMENT NOT NULL, date integer, content text)"];
    BOOL createKeywordTable = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS debug_keywords_table (log_id integer, keyword string)"];
    return createLogTable && createKeywordTable;
}

+ (void)insertLogModel:(DlogModel *)logModel toDb:(FMDatabase *)db {
    [db executeUpdate:@"insert into \"debug_logs_table\" (date, content) values(?,?)", [DLogTool timestampWithDate:logModel.date], logModel.content,logModel.keysArr];
    NSInteger logID = [db intForQuery:@"select MAX(log_id) from debug_logs_table"];
    for (NSString *keyword in logModel.keysArr) {
        [db executeUpdate:@"insert into \"debug_keywords_table\" (log_id, keyword) values(?,?)", @(logID), keyword];
    }
}

// "and" "or"
+ (NSArray<DlogModel *> *)searchLogmodelsWithKeyWords:(NSArray<NSString *> *)keywords option:(NSString *)option inDb:(FMDatabase *)db {
    FMResultSet *set = nil;
    if ([option isEqualToString:@"and"]) {
        set = [db executeQuery:@"select *from debug_logs_table WHERE log_id IN (select log_id FROM debug_keywords_table WHERE keyword IN value(?) GROUP BY log_id)", keywords];
    } else {
        
    }
    NSMutableArray<DlogModel *> *arr = @[].mutableCopy;
    while (set.next) {
        DlogModel *model = [[DlogModel alloc] init];
        model.logID = @([set intForColumn:@"log_id"]);
        model.content = [set stringForColumn:@"content"];
        model.date = [DLogTool dateWithTimestampNum:@([set intForColumn:@"date"])];
        [arr addObject:model];
    }
    return arr.copy;
}



@end
