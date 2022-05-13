//
//  RCLiveVideoEngine+ScreenShare.m
//  RCLiveVideoScreenShare
//
//  Created by shaoshuai on 2022/4/27.
//

#import "RCSceneScreenShare.h"
#import "RCLiveVideoEngine+ScreenShare.h"

@implementation RCLiveVideoEngine (ScreenShare)

- (void)enableScreenShare:(NSString *)clipID groupID:(NSString *)groupID {
    RCSceneScreenShare.shared.clipID = clipID;
    RCSceneScreenShare.shared.groupID = groupID;
    RCRTCOutputStream *stream = RCSceneScreenShare.shared.outputStream;
    if (stream) NSLog(@"screen output stream is created: %@", stream);
}

- (void)shareScreen {
    RPSystemBroadcastPickerView *pickerView = [RCSceneScreenShare shared].pickerView;
    for (UIView *view in pickerView.subviews) {
        if (![view isKindOfClass:[UIButton class]]) {
            continue;
        }
        [(UIButton *)view sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

@end
