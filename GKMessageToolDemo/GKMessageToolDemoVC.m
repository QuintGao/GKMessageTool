//
//  GKMessageToolDemoVC.m
//  GKMessageTool
//
//  Created by 高坤 on 2017/1/21.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import "GKMessageToolDemoVC.h"
#import "GKMessageTool.h"
#import "GKLoadingView.h"

@interface GKMessageToolDemoVC ()

@property (nonatomic, strong) UIView        *customView;
@property (nonatomic, strong) GKLoadingView *loadingView;

@property (nonatomic, strong) NSTimer   *timer;
@property (nonatomic, assign) float     progress;

@end

@implementation GKMessageToolDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:   // 在window上显示成功
            [GKMessageTool showSuccess:@"请求成功"];
            break;
        case 1:   // 在当前视图上显示成功
            [GKMessageTool showSuccess:@"请求成功" toView:self.view];
            break;
        case 2:   // 在window上显示失败
            [GKMessageTool showError:@"请求失败"];
            break;
        case 3:   // 在当前视图上显示失败
            [GKMessageTool showError:@"请求失败" toView:self.view];
            break;
        case 4:   // 在window上显示提示
            [GKMessageTool showTips:@"加载成功"];
            break;
        case 5:   // 在当前视图上显示提示
            [GKMessageTool showTips:@"加载成功" toView:self.view];
            break;
        case 6:   // 在window上显示加载中
        {
            [GKMessageTool showMessage:@"加载中..."];
            
            // 模拟加载
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [GKMessageTool hideMessage];
                
                [GKMessageTool showSuccess:@"加载成功"];
            });
        }
            break;
        case 7:   // 在当前视图上显示加载中
        {
            [GKMessageTool showMessage:@"加载中..." toView:self.view];
            
            // 模拟加载
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [GKMessageTool hideMessage];
                
                [GKMessageTool showError:@"加载失败" toView:self.view];
            });
        }
            break;
        case 8:   // 显示自定义视图
        {
            self.loadingView = [GKLoadingView loadingViewWithFrame:CGRectMake(0, 0, 50, 50) style:GKLoadingStyleDeterminate];
            self.loadingView.bgColor       = [UIColor grayColor];
            self.loadingView.strokeColor   = [UIColor whiteColor];
            self.loadingView.lineWidth     = 4;
            self.loadingView.radius        = 30;
            [self.loadingView.centerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.loadingView.progressChange = ^(GKLoadingView *loadingView, CGFloat progress) {
                NSString *text = [NSString stringWithFormat:@"%.f%%", progress * 100];
                [loadingView.centerButton setTitle:text forState:UIControlStateNormal];
            };
            [GKMessageTool showCustomView:self.loadingView text:@"素材加载中..."];
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
            
            NSLayoutConstraint*customViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.loadingView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:50.f];
            
            NSLayoutConstraint*customViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.loadingView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:70.f];
            [self.loadingView addConstraint:customViewWidthConstraint];
            [self.loadingView addConstraint:customViewHeightConstraint];
        }
            break;
        case 9:   // 隐藏加载中
            [GKMessageTool hideMessage];
            break;
        default:
            break;
    }
}

- (void)updateProgress:(id)sender {
    self.progress += 0.01;
    
    if (self.progress >= 1.0f) {
        self.progress = 1.0f;
        
        [self.timer invalidate];
        self.timer = nil;
        
        [GKMessageTool hideMessage];
    }
    
    self.loadingView.loadProgress = self.progress;
}

@end
