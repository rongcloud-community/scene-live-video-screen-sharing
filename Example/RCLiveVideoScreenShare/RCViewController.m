//
//  RCViewController.m
//  RCLiveVideoScreenShare
//
//  Created by shaoshuai on 04/27/2022.
//  Copyright (c) 2022 shaoshuai. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <RCLiveVideoLib/RCLiveVideoLib.h>
#import <RCLiveVideoScreenShare/RCLiveVideoScreenShare.h>

#import "RCViewController.h"

@interface RCViewController ()

@property (nonatomic, weak) IBOutlet UIView *contentView;

@property (nonatomic, weak) IBOutlet UIButton *beginButton;
@property (nonatomic, weak) IBOutlet UIButton *joinButton;
@property (nonatomic, weak) IBOutlet UIButton *recordButton;
@property (nonatomic, weak) IBOutlet UIButton *switchButton;

@end

@implementation RCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.beginButton setTitle:@"" forState:UIControlStateNormal];
    [self.joinButton setTitle:@"" forState:UIControlStateNormal];
    [self.recordButton setTitle:@"" forState:UIControlStateNormal];
    [self.switchButton setTitle:@"" forState:UIControlStateNormal];
    
    UIView *previewView = [RCLiveVideoEngine shared].previewView;
    [self.contentView addSubview:previewView];
    [previewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    NSString *groupID = @"group.cn.rc.scene";
    NSString *clipID = @"cn.rc.scene.video.screen.share";
    [[RCLiveVideoEngine shared] enableScreenShare:clipID groupID:groupID];
}

- (void)inputRoomIDAlert:(void(^)(NSString *roomID))completion {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"房间 ID" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [controller addAction:cancelAction];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = controller.textFields.firstObject;
        if (textField.text.length <= 0) return;
        completion(textField.text);
    }];
    [controller addAction:sureAction];
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入房间 ID";
        textField.text = @"ROOM_ID";
    }];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)begin {
    [self inputRoomIDAlert:^(NSString *roomID) {
        [[RCLiveVideoEngine shared] prepare];
        [[RCLiveVideoEngine shared] begin:roomID completion:^(RCLiveVideoCode code) {
            NSLog(@"live video did begin %d", (int)code);
        }];
        [self.beginButton setEnabled:NO];
        [self.joinButton setEnabled:NO];
        [self.recordButton setEnabled:YES];
        [self.switchButton setEnabled:NO];
    }];
}

- (IBAction)join {
    [self inputRoomIDAlert:^(NSString *roomID) {
        [[RCLiveVideoEngine shared] joinRoom:roomID completion:^(RCLiveVideoCode code) {
            NSLog(@"live video did join %d", (int)code);
        }];
        [self.beginButton setEnabled:NO];
        [self.joinButton setEnabled:NO];
        [self.recordButton setEnabled:NO];
        [self.switchButton setEnabled:YES];
    }];
}

- (IBAction)start {
    [[RCLiveVideoEngine shared] shareScreen];
}

- (IBAction)switchRole {
    
}

@end
