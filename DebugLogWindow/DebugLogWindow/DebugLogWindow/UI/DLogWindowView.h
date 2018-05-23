//
//  DLogWindowView.h
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/23.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLogWindowView : UIView


- (void)addText:(NSString *)appendStr;

- (NSArray *)testSearch:(NSString *)searchStr inMotherStr:(NSString *)motherStr;
@end
