#import <UIKit/UIKit.h>

typedef enum {
    WLTopicTypeAll = 1,
    WLTopicTypePicture = 10,
    WLTopicTypeWord = 29,
    WLTopicTypeVoice = 31,
    WLTopicTypeAudio = 41
    
}WLTopicType;

UIKIT_EXTERN CGFloat const titleViewH ;
UIKIT_EXTERN CGFloat const titleViewY ;
UIKIT_EXTERN NSString * const WLURL;
UIKIT_EXTERN CGFloat const contentY ;
UIKIT_EXTERN CGFloat const bottomH ;
UIKIT_EXTERN CGFloat const margin ;
UIKIT_EXTERN CGFloat const tagMargin ;
UIKIT_EXTERN CGFloat const tagHeight ;
/**
 *  精华cell图片的最大高度
 */
UIKIT_EXTERN CGFloat const cellPictureMaxH;
UIKIT_EXTERN CGFloat const cellPictureBreakH ;
/**
 *  用户性别
 */
UIKIT_EXTERN NSString * const WLUserSexMale ;
UIKIT_EXTERN NSString * const WLUserSexFemale ;

UIKIT_EXTERN CGFloat const cellTopcmtH ;
/**
 *  WLTabBarDidSelectedNotification 通知名称
        WLTabBarDidSelectedIndexKey 通知携带的点击的控制器下标
           WLTabBarDidSelectedVcKey 通知携带的点击的控制器
 */
UIKIT_EXTERN NSString * const WLTabBarDidSelectedNotification ;
UIKIT_EXTERN NSString * const WLTabBarDidSelectedIndexKey;
UIKIT_EXTERN NSString * const WLTabBarDidSelectedVcKey;


UIKIT_EXTERN NSString * const WLUserUid ;