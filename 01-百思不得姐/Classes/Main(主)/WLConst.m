#import <UIKit/UIKit.h>

/**
 *  主界面顶部 选择兰的 Y值和高度
 */
CGFloat const titleViewH = 64;
CGFloat const titleViewY = 32;
/**
 *  http请求路径
 */
NSString * const WLURL = @"http://api.budejie.com/api/api_open.php";
/**
 *  cell中文本的Y值间距以及底部拦的高度
 */
CGFloat const contentY = 55;
CGFloat const bottomH = 45;
CGFloat const margin = 10;

CGFloat const tagMargin = 5;
CGFloat const tagHeight = 35;
/**
 *  精华cell图片的最大高度
 */
CGFloat const cellPictureMaxH = 800;
CGFloat const cellPictureBreakH = 250;

NSString * const WLUserSexMale = @"m";
NSString * const WLUserSexFemale = @"f";

CGFloat const cellTopcmtH = 20;

NSString * const WLTabBarDidSelectedNotification = @"WLTabBarDidSelectedNotification";
NSString * const WLTabBarDidSelectedIndexKey = @"WLTabBarDidSelectedIndexKey";
NSString * const WLTabBarDidSelectedVcKey = @"WLTabBarDidSelectedVcKey";

NSString * const WLUserUid = @"WLUserUid";