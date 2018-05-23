//
//  DLogWindowView.m
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/23.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import "DLogWindowView.h"
#import <Masonry.h>

@interface DLogWindowView()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) BOOL isUserTouching;
@property (nonatomic, strong) NSMutableString *totalString;
@property (nonatomic, assign) NSTimeInterval delayAutoToScrollInterval;

@end

@implementation DLogWindowView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self comInit];
    }
    return self;
}

- (void)comInit {
    self.totalString = @"".mutableCopy;
    
    self.textView = [[UITextView alloc] init];
    self.textView.textColor = [UIColor whiteColor];
    self.textView.backgroundColor = [UIColor blackColor];
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.text = @"";
    self.textView.delegate = self;
    self.textView.layoutManager.allowsNonContiguousLayout = YES;
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - UITextViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [DLogWindowView cancelPreviousPerformRequestsWithTarget:self selector:@selector(setUserTouchingToNO) object:nil];
    self.isUserTouching = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate == YES) {
    } else {
        [self performSelector:@selector(setUserTouchingToNO) withObject:nil afterDelay:self.delayAutoToScrollInterval];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self performSelector:@selector(setUserTouchingToNO) withObject:nil afterDelay:self.delayAutoToScrollInterval];
}

- (void)addText:(NSString *)appendStr {
    [self.totalString appendString:appendStr];
    self.textView.text = self.totalString;
    if (self.isUserTouching) {
        return;
    }
    [self.textView scrollRangeToVisible:NSMakeRange(self.totalString.length, 1)];
}


- (NSArray *)testSearch:(NSString *)searchStr inMotherStr:(NSString *)motherStr {
    NSMutableArray *rangeArr = @[].mutableCopy;
    NSRange range = [motherStr rangeOfString:searchStr options:NSBackwardsSearch range:NSMakeRange(0, motherStr.length)];
    //循环检索
    while(range.location != NSNotFound)
    {
        NSLog(@"start = %@",NSStringFromRange(range));
        [rangeArr insertObject:[NSValue valueWithRange:range] atIndex:0];
        NSUInteger start = 0;
        NSUInteger end = range.location;
        NSRange temp = NSMakeRange(start,end);
        range = [motherStr rangeOfString:searchStr options:NSBackwardsSearch range:temp];
    }
    return rangeArr.copy;
}

- (void)setUserTouchingToNO {
    self.isUserTouching = NO;
}


- (void)setIsUserTouching:(BOOL)isUserTouching {
    _isUserTouching = isUserTouching;
}

- (NSTimeInterval)delayAutoToScrollInterval {
    if (_delayAutoToScrollInterval <=0) {
        _delayAutoToScrollInterval = 5;
    }
    return _delayAutoToScrollInterval;
}

@end
