//
//  DLogWindowView.m
//  DebugLogWindow
//
//  Created by luochaojing on 2018/5/23.
//  Copyright © 2018年 luochaojing. All rights reserved.
//

#import "DLogWindowView.h"
#import <Masonry/Masonry.h>
#import "DLogDataBaseMgr.h"
#import "DlogModel.h"

@interface DLogWindowView()<UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) BOOL isUserTouching;
@property (nonatomic, strong) NSMutableString *totalString;
@property (nonatomic, assign) NSTimeInterval delayAutoToScrollInterval;

@property (nonatomic, strong) UITextField *inputTextField;

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
    self.textView.text = self.totalString;
    self.textView.delegate = self;
    self.textView.layoutManager.allowsNonContiguousLayout = YES;

    self.textView.editable = NO;
    
    self.inputTextField = [[UITextField alloc] init];
    self.inputTextField.textAlignment = NSTextAlignmentLeft;
    self.inputTextField.placeholder = @"输入关键词搜索";
    self.inputTextField.textColor = [UIColor blackColor];
    self.inputTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.inputTextField.layer.borderWidth = [UIScreen mainScreen].scale;
    self.inputTextField.delegate = self;
    
    [self addSubview:self.textView];
    [self addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@46);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputTextField.mas_bottom);
        make.left.right.bottom.equalTo(self);
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


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textf.text = %@", textField.text);
    [self searchWithKey:textField.text];
}

// search
- (void)searchWithKey:(NSString *)key {
    [[DLogDataBaseMgr shared] searchLogmodelsWithKeyWords:@[key] option:@"and" then:^(NSArray<DlogModel *> *arr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            for (DlogModel *model in arr) {
                [self addText:model.content];
            }
        });
    }];
}


//
- (void)addText:(NSString *)appendStr {
    [self.totalString appendString:appendStr];
    if (self.isUserTouching) {
        return;
    }
    self.textView.text = self.totalString;
    [self.textView scrollRangeToVisible:NSMakeRange(self.totalString.length, 1)];
}

- (void)clear {
    self.totalString = @"".mutableCopy;
    self.textView.text = self.totalString;
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
