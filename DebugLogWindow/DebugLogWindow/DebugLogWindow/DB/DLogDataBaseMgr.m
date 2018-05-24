//
//  DLogDataBaseMgr.m
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/22.
//  Copyright © 2018年 luochaojing. All rights reserved.
//


//#if FMDB_SQLITE_STANDALONE
//#import <sqlite3/sqlite3.h>
//#else
//#import <sqlite3.h>
//#endif
#import "DLogDataBaseMgr.h"
#import <FMDB.h>
#import "DLogDBTable.m"
#import <sqlite3.h>



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
    _dbPath  = @"debug.db";
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

@end
