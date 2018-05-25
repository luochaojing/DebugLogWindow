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
#import "DLogDataBaseMgr.h"
#import "DlogModel.h"

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
    //[self creatTimer];
    
    [self testSearch];
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
    NSString *appendText = [NSString stringWithFormat:@"%@、log内容\n", @(i)];
    [self.logView addText:appendText];
    i++;
    [self testDBWithContent:appendText];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)testDBWithContent:(NSString *)content {
    DlogModel *model = [[DlogModel alloc] init];
    model.keysArr = @[@"key1", @"key2"];
    model.content = content;
    model.date = [NSDate date];
    [[DLogDataBaseMgr shared] addLogModel:model];
}

- (void)testSearch {
    [[DLogDataBaseMgr shared] searchLogmodelsWithKeyWords:@[@"key1"] option:@"and" then:^(NSArray<DlogModel *> *arr) {
        NSArray *x = arr;
        NSLog(@"x.count = %@", x);
    }];
}


@end
