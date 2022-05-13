//
//  RCSceneScreenShare.h
//  RCLiveVideoScreenShare
//
//  Created by shaoshuai on 2022/4/27.
//

#import <ReplayKit/ReplayKit.h>
#import <RongRTCLib/RongRTCLib.h>

NS_ASSUME_NONNULL_BEGIN

#define kScreenShareGroupID @"group.cn.rc.scene"

@interface RCSceneScreenShare : NSObject <RCRTCEngineEventDelegate>

@property (nonatomic, copy) NSString *clipID;
@property (nonatomic, copy) NSString *groupID;

@property (nonatomic, strong) RPSystemBroadcastPickerView *pickerView;

@property (nonatomic, strong) RCRTCScreenShareOutputStream *outputStream;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
