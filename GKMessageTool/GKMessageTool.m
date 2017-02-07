//
//  GKMessageTool.m
//  GKMessageTool
//
//  Created by 高坤 on 2017/1/21.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import "GKMessageTool.h"

static MBProgressHUD *_hud;

@interface GKMessageTool()

@property (nonatomic, strong) MBProgressHUD *showMessage;

@end

@implementation GKMessageTool

+ (void)load
{
    UIActivityIndicatorView *indicatorView = [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil];
    // 设置指示器颜色
    indicatorView.color = [UIColor whiteColor];
}

+ (instancetype)shareInstance
{
    static GKMessageTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [GKMessageTool new];
    });
    return tool;
}

#pragma mark - Public Method

+ (void)showSuccess:(NSString *)success
{
    [kMessageTool showMessage:success toView:nil isSuccess:YES];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)toView
{
    [kMessageTool showMessage:success toView:toView isSuccess:YES];
}

+ (void)showError:(NSString *)error
{
    [kMessageTool showMessage:error toView:nil isSuccess:NO];
}

+ (void)showError:(NSString *)error toView:(UIView *)toView
{
    [kMessageTool showMessage:error toView:toView isSuccess:NO];
}

+ (void)showTips:(NSString *)tips
{
    NSString *imageName = [NSString stringWithFormat:@"GKMessageTool.bundle/%@", @"info_white.png"];
    [kMessageTool showMessage:tips toView:nil imageName:imageName];
}

+ (void)showTips:(NSString *)tips toView:(UIView *)toView
{
    NSString *imageName = [NSString stringWithFormat:@"GKMessageTool.bundle/%@", @"info_white.png"];
    [kMessageTool showMessage:tips toView:toView imageName:imageName];
}

+ (void)showMessage:(NSString *)message
{
    _hud = [self showLoadMessage:message toView:nil];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)toView
{
    _hud = [self showLoadMessage:message toView:toView];
}

+ (MBProgressHUD *)showLoadMessage:(NSString *)message toView:(UIView *)toView
{
    [kMessageTool showLoadMessage:message toView:toView];
    
    return kMessageTool.showMessage;
}

+ (void)hideMessage
{
    [_hud hideAnimated:YES];
}

#pragma mark - Private Method

/**
 获取当前最顶层的window
 */
- (UIWindow *)getTopLevelWindow
{
    UIWindow *window = nil;
    for (UIWindow *_window in [UIApplication sharedApplication].windows) {
        if (window == nil) {
            window = _window;
        }
        if (_window.windowLevel > window.windowLevel) {
            window = _window;
        }
    }
    return window;
}

- (void)hideMessage
{
    [self.showMessage hideAnimated:YES afterDelay:1.0];
}

- (void)showMessage:(NSString *)message toView:(UIView *)toView isSuccess:(BOOL)success
{
    NSString *imageName = [NSString stringWithFormat:@"GKMessageTool.bundle/%@",success ? @"success_white.png" : @"error_white.png"];
    
    [self showMessage:message toView:toView imageName:imageName];
}

- (void)showMessage:(NSString *)message toView:(UIView *)toView imageName:(NSString *)imageName
{
    if (self.showMessage) [self.showMessage removeFromSuperview];
    
    if (!toView) toView = [self getTopLevelWindow];
    
    // 创建指示器
    self.showMessage = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    // 设置为自定义模式
    self.showMessage.mode = MBProgressHUDModeCustomView;
    // 隐藏时从父控件中移除
    self.showMessage.removeFromSuperViewOnHide = YES;
    // 设置将要显示的图片
    UIImage *image = [UIImage imageNamed:imageName];
    // 设置自定义视图
    self.showMessage.customView = [[UIImageView alloc] initWithImage:image];
    // 设置bezelView背景色
    self.showMessage.bezelView.color = [UIColor blackColor];
    self.showMessage.bezelView.layer.cornerRadius = 10.0;
    
    // 设置显示的文字内容
    self.showMessage.label.text = message;
    self.showMessage.label.font = [UIFont systemFontOfSize:14.0];
    self.showMessage.label.textColor = [UIColor whiteColor];
    
    [self performSelectorOnMainThread:@selector(hideMessage) withObject:nil waitUntilDone:YES];
}

- (void)showLoadMessage:(NSString *)message toView:(UIView *)toView
{
    if (self.showMessage) [self.showMessage removeFromSuperview];
    if (!toView) toView = [self getTopLevelWindow];
    
    // 创建hud
    self.showMessage = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    // 设置背景颜色和圆角
    self.showMessage.bezelView.color = [UIColor blackColor];
    self.showMessage.bezelView.layer.cornerRadius = 10.0;
    // 设置文字内容和颜色
    self.showMessage.label.text = message;
    self.showMessage.label.textColor = [UIColor whiteColor];
}


























@end
