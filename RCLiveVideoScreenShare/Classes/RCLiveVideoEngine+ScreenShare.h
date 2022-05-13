//
//  RCLiveVideoEngine+ScreenShare.h
//  RCLiveVideoScreenShare
//
//  Created by shaoshuai on 2022/4/27.
//

#import <RCLiveVideoLib/RCLiveVideoLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCLiveVideoEngine (ScreenShare)

/// 激活屏幕录制功能，同时创建屏幕分享流(RCRTCScreenShareOutputStream)对象
/// @param clipID 扩展程序 ID
/// @param groupID 应用组 ID
- (void)enableScreenShare:(NSString *)clipID groupID:(NSString *)groupID;

/// 开始屏幕分享
- (void)shareScreen;

@end

NS_ASSUME_NONNULL_END
