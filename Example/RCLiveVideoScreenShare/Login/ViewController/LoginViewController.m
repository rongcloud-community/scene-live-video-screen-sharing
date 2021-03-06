//
//  RCRTCLoginViewController.m
//  RCRTCQuickDemo
//
//  Copyright © 2021 RongCloud. All rights reserved.
//

#import "LoginViewController.h"
#import "RequestToken.h"
#import "Constant.h"
#import "RCViewController.h"

#import <RongIMLibCore/RongIMLibCore.h>

/*!
 登录页面，用来处理 IM 登录逻辑
 请求 Token
 初始化 Appkey
 连接 IM
 */
@interface LoginViewController ()

@property(nonatomic, weak) IBOutlet UITextField *useridTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] stringForKey:@"kUserID"];
    _useridTextField.text = userID;
}

// 点击连接 IM 服务
- (IBAction)connectIMServer:(UIButton *)sender {
    if (!self.useridTextField.text || self.useridTextField.text.length == 0) {
        return;
    }
    [self.useridTextField resignFirstResponder];
    [[NSUserDefaults standardUserDefaults] setObject:_useridTextField.text forKey:@"kUserID"];

    // 获取 Token
    [RequestToken requestToken:self.useridTextField.text
                          name:self.useridTextField.text
                   portraitUrl:nil
             completionHandler:^(BOOL isSuccess, NSString *_Nonnull tokenString) {
                 if (!isSuccess) return;
                 // 拿到 Token 后去连接 IM 服务
                 [self connectRongCloud:tokenString];
             }];
}

// 初始化 AppKey 并连接 IM
- (void)connectRongCloud:(NSString *)token {
    [[RCCoreClient sharedCoreClient] initWithAppKey:AppKey];
    [[RCCoreClient sharedCoreClient] connectWithToken:token dbOpened:nil success:^(NSString *userId) {
        NSLog(@"IM connect success,user ID : %@", userId);
        // 回调处于子线程，需要回调到主线程进行 UI 处理。
        dispatch_async(dispatch_get_main_queue(), ^{
            RCViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RCViewController"];
            [self.navigationController pushViewController:homeVC animated:YES];
        });
    }                                           error:^(RCConnectErrorCode errorCode) {
        NSLog(@"IM connect failed, error code : %ld", (long) errorCode);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.useridTextField resignFirstResponder];
}

@end
