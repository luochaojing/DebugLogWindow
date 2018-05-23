//
//  ViewController.m
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/22.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import "ViewController.h"
#import "DLogWindowView.h"
#import <Masonry.h>

@interface ViewController ()

@property (strong, nonatomic) DLogWindowView *logView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DLogWindowView *view = [[DLogWindowView alloc] init];
    [view testSearch:@"abc" inMotherStr:@"abcabc12asfdasasfabc"];
    self.logView = view;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    [self creatTimer];
}

- (void)creatTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:.1 target:self selector:@selector(addText) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)addText {
    static NSInteger i = 0;
    if (i > 15) {
        return;
    }
    NSString *appendText = [NSString stringWithFormat:@"标签ADFDSFASDSDFASDFASDFASDFD你今天去哪里干点什么啊啊啊啊今天早餐的是三个包子还是三万州么的：%@\n", @(i)];
//    for (NSInteger x = 0; x < 5; x++) {
//        appendText = [appendText stringByAppendingString:appendText];
//    }
    NSLog(@"%@", appendText);
    [self.logView addText:appendText];
    i++;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
