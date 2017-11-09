
#import <UIKit/UIKit.h>

@interface XGTCAudioPlayView : UIView

@property (nonatomic, copy) NSString *url; //网络资源链接
@property (nonatomic, copy) NSString *filePath; //url对应的本地文件路径
@property (nonatomic, assign) NSInteger totalLength; //总时长
@property (nonatomic, assign) NSInteger leftLength; //剩余时长
@property (nonatomic, assign) NSInteger state; //状态（0是未被点击，1是被点击后播放）

@end
