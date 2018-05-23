//
//  DlogModel.h
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/22.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DlogModel : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSArray<NSString *> *keysArr;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *logID;


@end
