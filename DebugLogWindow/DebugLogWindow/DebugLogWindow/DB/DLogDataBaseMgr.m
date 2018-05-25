//
//  DLogDataBaseMgr.m
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/22.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import "DLogDataBaseMgr.h"

#if FMDB_SQLITE_STANDALONE
#import <sqlite3/sqlite3.h>
#else
#import <sqlite3.h>
#endif
#import <FMDB.h>
#import "DLogDBTable.h"


@interface DLogDataBaseMgr()

@property (strong, nonatomic) FMDatabaseQueue *dbQueue;
@property (strong, nonatomic) NSOperationQueue *dispatchQueue;
@property (copy, nonatomic) NSString *dbPath;

@end

@implementation DLogDataBaseMgr


+ (DLogDataBaseMgr *)shared {
    static dispatch_once_t onceToken;
    static DLogDataBaseMgr *single = nil;
    dispatch_once(&onceToken, ^{
        single = [[self alloc] init];
    });
    return single;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        [self createDefaultConfig];
    }
    return self;
}


- (void)createDefaultConfig {
    NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path = [arr objectAtIndex:0];
    _dbPath = [path stringByAppendingPathComponent:@"debug_log.db"];
    _dbQueue = [[FMDatabaseQueue alloc] initWithPath:_dbPath flags:SQLITE_OPEN_FILEPROTECTION_NONE | SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE | SQLITE_OPEN_WAL];
    _dispatchQueue = [[NSOperationQueue alloc] init];
    _dispatchQueue.maxConcurrentOperationCount = 1;
    [self inAsyncMainDatabase:^(FMDatabase *db) {
        [DLogDBTable createLogTableInDb:db];
    }];
}

- (void)inAsyncMainDatabase:(void(^)(FMDatabase *db))then {
    [self.dispatchQueue addOperationWithBlock:^{
        [self.dbQueue inDatabase:then];
    }];
}

- (void)addLogModel:(DlogModel *)logModel {
    [self inAsyncMainDatabase:^(FMDatabase *db) {
        [DLogDBTable insertLogModel:logModel toDb:db];
    }];
}

- (void)searchLogmodelsWithKeyWords:(NSArray<NSString *> *)keywords option:(NSString *)option then:(void (^)(NSArray<DlogModel *> *))then {
    [self inAsyncMainDatabase:^(FMDatabase *db) {
        NSArray<DlogModel *> *arr = [DLogDBTable searchLogmodelsWithKeyWords:keywords option:option inDb:db];
        !then?:then(arr);
    }];
}



@end
