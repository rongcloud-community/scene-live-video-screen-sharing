//
//  RCLiveVideoLayout.h
//  RCE
//
//  Created by shaoshuai on 2021/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RCRTCLiveInfo;

@interface RCLiveVideoLayout : NSObject

@property (class, nonatomic, strong, nullable) RCRTCLiveInfo *liveInfo;

+ (CGRect)convert:(CGRect)frame toView:(UIView *)view;

+ (void)layout;
+ (void)layout:(void(^)(BOOL success))completion;

@end

NS_ASSUME_NONNULL_END
