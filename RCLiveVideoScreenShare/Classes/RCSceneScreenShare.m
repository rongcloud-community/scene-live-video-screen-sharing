//
//  RCSceneScreenShare.m
//  RCLiveVideoScreenShare
//
//  Created by shaoshuai on 2022/4/27.
//

#import "RCLiveVideoLayout.h"
#import "RCSceneScreenShare.h"

@implementation RCSceneScreenShare

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static RCSceneScreenShare *instance;
    dispatch_once(&onceToken, ^{
        instance = [[RCSceneScreenShare alloc] init];
        [[RCRTCEngine sharedInstance] setDelegate:instance];
    });
    return instance;
}

- (RPSystemBroadcastPickerView *)pickerView {
    if (!_groupID || !_clipID) return nil;
    if (_pickerView) return _pickerView;
    _pickerView = [[RPSystemBroadcastPickerView alloc] init];
    _pickerView.preferredExtension = self.clipID;
    _pickerView.backgroundColor = UIColor.clearColor;
    return _pickerView;
}

- (RCRTCScreenShareOutputStream *)outputStream {
    if (_outputStream) return _outputStream;
    _outputStream = [[RCRTCEngine sharedInstance] getScreenShareVideoStreamWithGroupId:kScreenShareGroupID];
    
    RCRTCVideoStreamConfig *config = [[RCRTCVideoStreamConfig alloc] init];
    config.videoSizePreset = RCRTCVideoSizePreset1280x720;
    config.videoFps = RCRTCVideoFPS30;
    [_outputStream setVideoConfig:config];
    
    return _outputStream;
}

#pragma mark - RCRTCEngineEventDelegate -

- (void)screenShareExtentionStarted {
    [RCRTCEngine.sharedInstance.defaultVideoStream stopCapture];
    RCRTCLocalUser *localUser = [RCRTCEngine sharedInstance].room.localUser;
    RCRTCOutputStream *stream = [RCSceneScreenShare shared].outputStream;
    RCRTCOutputStream *videoStream = [RCRTCEngine sharedInstance].defaultVideoStream;
    [localUser unpublishLiveStream:videoStream completion:^(BOOL isSuccess, RCRTCCode code) {
        [localUser publishLiveStream:stream completion:^(BOOL isSuccess, RCRTCCode code, RCRTCLiveInfo * _Nullable liveInfo) {
            RCLiveVideoLayout.liveInfo = liveInfo;
            [RCLiveVideoLayout layout];
        }];
    }];
}

- (void)screenShareExtentionFinished {
    [RCRTCEngine.sharedInstance.defaultVideoStream startCapture];
    RCRTCLocalUser *localUser = [RCRTCEngine sharedInstance].room.localUser;
    RCRTCOutputStream *stream = [RCSceneScreenShare shared].outputStream;
    RCRTCOutputStream *videoStream = [RCRTCEngine sharedInstance].defaultVideoStream;
    [localUser unpublishLiveStream:stream completion:^(BOOL isSuccess, RCRTCCode code) {
        [localUser publishLiveStream:videoStream completion:^(BOOL isSuccess, RCRTCCode code, RCRTCLiveInfo * _Nullable liveInfo) {
            RCLiveVideoLayout.liveInfo = liveInfo;
            [RCLiveVideoLayout layout];
        }];
    }];
}

@end
