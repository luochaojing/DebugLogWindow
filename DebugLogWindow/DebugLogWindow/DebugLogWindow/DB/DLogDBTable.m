//
//  DLogDBTable.m
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/22.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import "DLogDBTable.h"
#import <FMDB.h>

@implementation DLogDBTable


+ (void)insertLogModel:(DlogModel *)logModel toDb:(FMDatabase *)db {
    [db executeUpdate:@"insert "];
}

@end
