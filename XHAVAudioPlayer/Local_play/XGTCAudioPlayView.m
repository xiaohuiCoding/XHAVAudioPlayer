
#import "XGTCAudioPlayView.h"
#import "XGTCAVAudioManager.h"
#import "UIView+AutolayoutSetter.h"
#import "AFNetworking.h"

@interface XGTCAudioPlayView ()

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UILabel *lengthLabel;
@property (nonatomic, strong) UIImageView *voiceIcon;
@property (nonatomic, strong) NSTimer *timer; //定时器(用于监听播放进度)
@property (nonatomic, strong) NSTimer *timerDownLoad; //定时器(用于监听下载进度)
@property (nonatomic, copy) NSString *progressStr; //下载进度

@end

@implementation XGTCAudioPlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setSubviews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAllPlayingThings) name:@"EmptyPlaying" object:nil];
    }
    return self;
}

- (void)removeAllPlayingThings
{
    [[XGTCAVAudioManager sharedInstance] stop];
    [XGTCAVAudioManager sharedInstance].player = nil;
    [XGTCAVAudioManager sharedInstance].currentPlayingFilePath = @"";
    [self removeTimer];
}

- (void)setSubviews
{
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.playButton];
    [self.playButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.playButton al_alignSuperLeft:15];
    [self.playButton al_alignSuperVerticalCenter];
    
    self.lengthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.lengthLabel.font = [UIFont systemFontOfSize:11.0];
    self.lengthLabel.textColor = [UIColor whiteColor];
    self.lengthLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.lengthLabel];
    self.lengthLabel.backgroundColor = [UIColor lightGrayColor];
    self.lengthLabel.layer.cornerRadius = 8;
    self.lengthLabel.layer.masksToBounds = YES;
    [self.lengthLabel al_layRightOf:self.playButton distance:10];
    [self.lengthLabel al_alignSuperVerticalCenter];
    [self.lengthLabel al_setSize:CGSizeMake(45, 15)];
    
    self.voiceIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.voiceIcon];
    [self.voiceIcon al_layRightOf:self.lengthLabel distance:15];
    [self.voiceIcon al_alignSuperVerticalCenter];
    [self.voiceIcon al_setSize:CGSizeMake(12, 20)];
}

- (void)setTotalLength:(NSInteger)totalLength
{
    _totalLength = totalLength;
    [self showTimeWithInteger:totalLength];
}

- (void)setLeftLength:(NSInteger)leftLength
{
    _leftLength = leftLength;
}

- (void)setState:(NSInteger)state
{
    _state = state;
    
    if (state == 0) {
        [self.playButton setImage:[UIImage imageNamed:@"icon_play_noraml"] forState:UIControlStateNormal];
        [self showTimeWithInteger:self.leftLength];
        [self removeTimer];
    } else {
        [self.playButton setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
        self.totalLength = (NSInteger)([XGTCAVAudioManager sharedInstance].player.duration - [XGTCAVAudioManager sharedInstance].player.currentTime);
        [self startAnimationByView:self.voiceIcon];
        if (self.totalLength != self.leftLength) {
            [self addTimer];
        }
    }
}

- (void)buttonClicked
{
    if (self.state == 0) {
        [self playAudio];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayRefresh" object:nil];
    } else {
        [self stopPlayAudio];
        [XGTCAVAudioManager sharedInstance].currentPlayingFilePath = @"";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayRefresh" object:nil];
    }
}

- (void)playAudio
{
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *str = [@"/2017" stringByAppendingString:[self.url componentsSeparatedByString:@"2017"][1]];
//    NSString *folderName = [path stringByAppendingString:str];
//    //检索沙盒中是否已有该音频文件，没有才下载
//    if (![[NSFileManager defaultManager] fileExistsAtPath:folderName]) {
//
//        if (![self checkNet]) {
//            return;
//        }
////        [kKeyWindow hudPostLoading:@"下载中"];
//
//        self.timerDownLoad = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(checkDownLoadProgress) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:self.timerDownLoad forMode:NSRunLoopCommonModes];
//
////        @weakify(self)
////        [NetAPI downloadFileWithURLString:self.url result:^(NSURL *filePath, float progressNumber, NSString *progressString, NSError *error) {
////            @strongify(self)
////
////            self.progressStr = progressString;
////        }];
//
//    } else {
        [[XGTCAVAudioManager sharedInstance] playWithFilePath:self.filePath];
        [XGTCAVAudioManager sharedInstance].currentPlayingFilePath = self.filePath;
        [self addTimer];
        self.state = 1;
        self.totalLength = self.leftLength;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayRefresh" object:nil];
//    }
}

- (void)addTimer
{
    [self removeTimer];
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshLengthLabel) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)refreshLengthLabel
{
    if (self.totalLength == 0) {
        [self stopPlayAudio];
        [self removeTimer];
        [XGTCAVAudioManager sharedInstance].currentPlayingFilePath = @"";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayRefresh" object:nil];
        return;
    }
    self.totalLength --;
    [self showTimeWithInteger:self.totalLength];
}

- (void)stopPlayAudio
{
    if ([self.filePath isEqualToString:[XGTCAVAudioManager sharedInstance].currentPlayingFilePath]) {
        [[XGTCAVAudioManager sharedInstance] stop];
        [self showTimeWithInteger:self.leftLength];
        [self stopAnimationByView:self.voiceIcon];
        [self removeTimer];
        self.state = 0;
    }
}

- (void)removeTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

//检查网络
- (BOOL)checkNet
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    if (!manager.reachable) {
//        [kKeyWindow hudPostError:@"网络异常，请稍后再试"];
        return NO;
    }
    return YES;
}

//监听下载进度
- (void)checkDownLoadProgress
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayRefresh" object:nil];
    
    if ([self.progressStr isEqualToString:@"100.00%"]) {
        
        if (self.timerDownLoad) {
            [self.timerDownLoad invalidate];
            self.timerDownLoad = nil;
        }
        
        self.progressStr = @""; // 置空
//        [kKeyWindow hudCleanUp:YES];
        
        [self addTimer];
        [[XGTCAVAudioManager sharedInstance] playWithFilePath:self.filePath];
        [XGTCAVAudioManager sharedInstance].currentPlayingFilePath = self.filePath;
        self.state = 1;
        self.totalLength = self.leftLength;
    }
}

- (void)showTimeWithInteger:(NSInteger)num
{
    if (num <= 9) {
        self.lengthLabel.text = [NSString stringWithFormat:@"00:0%ld",(long)num];
    } else if (num > 9 && num <= 59) {
        self.lengthLabel.text = [NSString stringWithFormat:@"00:%ld",(long)num];
    } else {
        self.lengthLabel.text = @"01:00";
    }
}

- (void)startAnimationByView:(UIImageView *)voiceIcon {
    
    NSMutableArray  *arrayM=[NSMutableArray array];
    for (int i=1; i<4; i++) {
        [arrayM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"play_%d",i]]];
    }
    //设置动画数组
    [voiceIcon setAnimationImages:arrayM];
    //设置动画播放次数
    [voiceIcon setAnimationRepeatCount:self.totalLength];
    //设置动画播放时间
    [voiceIcon setAnimationDuration:1];
    //开始动画
    [voiceIcon startAnimating];
}

- (void)stopAnimationByView:(UIImageView *)voiceIcon
{
    [voiceIcon stopAnimating];
    voiceIcon.animationImages = nil;
}

@end
