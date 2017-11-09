
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface XGTCAVAudioManager : NSObject

@property (nonatomic, strong) AVAudioPlayer *player; //播放器
@property (nonatomic, copy) NSString *currentPlayingFilePath; //当前正在播放的资源对应的本地文件路径

+ (XGTCAVAudioManager *)sharedInstance;

- (AVAudioPlayer *)player;

- (void)playWithFilePath:(NSString *)string;

- (void)stop;

@end
