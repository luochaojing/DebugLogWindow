//
//  DlogModel.m
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/22.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import "DlogModel.h"

@implementation DlogModel

- (NSString *)description {
    NSString *keys = [self.keysArr componentsJoinedByString:@","];
    return [NSString stringWithFormat:@"%@:\n keys:%@ \n %@",self.date, keys, self.content];
}

@end
