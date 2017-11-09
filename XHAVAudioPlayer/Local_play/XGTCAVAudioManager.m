
#import "XGTCAVAudioManager.h"

@implementation XGTCAVAudioManager

+ (XGTCAVAudioManager *)sharedInstance
{
    static XGTCAVAudioManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XGTCAVAudioManager alloc] init];
    });
    return instance;
}

//- (AVAudioPlayer *)player
//{
//    if (!_player) {
//        _player = [[AVAudioPlayer alloc] init];
//    }
//    return _player;
//}

- (void)playWithFilePath:(NSString *)string
{
    if (!_player) {
        _player = [[AVAudioPlayer alloc] init];
    }
    if (self.currentPlayingFilePath && ![self.currentPlayingFilePath isEqualToString:@""]) {
        self.currentPlayingFilePath = @"";
        [self stop];
    }
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:string] error:nil];
    [self.player prepareToPlay];
    [self.player play];
}

- (void)stop
{
    if ([self.player isPlaying]) {
        [self.player stop];
    }
}

@end
