//
//  GKMessageTool.h
//  GKMessageTool
//
//  Created by 高坤 on 2017/1/21.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

#define kMessageTool [GKMessageTool shareInstance]

@interface GKMessageTool : NSObject<MBProgressHUDDelegate>

/**
 单例
 */
+ (instancetype)shareInstance;

/**
 显示成功
 */
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)toView;


/**
 显示失败
 */
+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)toView;


/**
 显示提示
 */
+ (void)showTips:(NSString *)tips;
+ (void)showTips:(NSString *)tips toView:(UIView *)toView;


/**
 显示加载中
 */
+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message toView:(UIView *)toView;

+ (void)showNoClickMessage:(NSString *)message;
+ (void)showNoClickMessage:(NSString *)message toView:(UIView *)toView;


/**
 隐藏加载中
 */
+ (void)hideMessage;

@end
