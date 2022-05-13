//
//  SampleHandler.m
//  RCSceneScreenShare
//
//  Created by shaoshuai on 2022/4/27.
//  Copyright © 2022 shaoshuai. All rights reserved.
//

#import <RongRTCReplayKitExt/RongRTCReplayKitExt.h>

#import "SampleHandler.h"

@interface SampleHandler () <RongRTCReplayKitExtDelegate>

@end

@implementation SampleHandler

- (void)broadcastStartedWithSetupInfo:(NSDictionary<NSString *,NSObject *> *)setupInfo {
    [[RCRTCReplayKitEngine sharedInstance] setupWithAppGroup:@"group.cn.rc.scene" delegate:self];
}

- (void)broadcastPaused {
    [[RCRTCReplayKitEngine sharedInstance] broadcastPaused];
}

- (void)broadcastResumed {
    [[RCRTCReplayKitEngine sharedInstance] broadcastResumed];
}

- (void)broadcastFinished {
    [[RCRTCReplayKitEngine sharedInstance] broadcastFinished];
}

- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer withType:(RPSampleBufferType)sampleBufferType {
    
    switch (sampleBufferType) {
        case RPSampleBufferTypeVideo:
            [[RCRTCReplayKitEngine sharedInstance] sendSampleBuffer:sampleBuffer
                                                           withType:sampleBufferType];
            break;
        case RPSampleBufferTypeAudioApp:
            // Handle audio sample buffer for app audio
            break;
        case RPSampleBufferTypeAudioMic:
            // Handle audio sample buffer for mic audio
            break;
            
        default:
            break;
    }
}

- (void)broadcastFinished:(RCRTCReplayKitEngine *)broadcast
                   reason:(RCRTCReplayKitExtReason)reason {
    NSString *tip = @"";
    switch (reason) {
        case RCRTCReplayKitExtReasonRequestDisconnectByMain:
            tip = @"屏幕共享已结束";
            break;
        case RCRTCReplayKitExtReasonDisconnected:
            tip = @"应用断开";
            break;
        case RCRTCReplayKitExtReasonVersionMismatch:
            tip = @"集成错误（SDK 版本号不相符合）";
            break;
        default:
            return;
    }

    NSError *error = [NSError errorWithDomain:NSStringFromClass(self.class)
                                         code:0
                                     userInfo:@{
        NSLocalizedFailureReasonErrorKey:tip
    }];
    [self finishBroadcastWithError:error];
}

@end
