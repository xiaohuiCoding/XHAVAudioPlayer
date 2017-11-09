
#import "XGTCKeYuanHistoryCell.h"
#import "XGTCAudioPlayView.h"
#import "XGTCAVAudioManager.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface XGTCKeYuanHistoryCell ()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) XGTCAudioPlayView *audioPlayView1;
@property (nonatomic, strong) XGTCAudioPlayView *audioPlayView2;
@property (nonatomic, strong) XGTCAudioPlayView *audioPlayView3;

@end

@implementation XGTCKeYuanHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.line];
    
    self.audioPlayView1 = [[XGTCAudioPlayView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 80)];
    [self.contentView addSubview:self.audioPlayView1];
    
    self.audioPlayView2 = [[XGTCAudioPlayView alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 80)];
    [self.contentView addSubview:self.audioPlayView2];
    
    self.audioPlayView3 = [[XGTCAudioPlayView alloc] initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 80)];
    [self.contentView addSubview:self.audioPlayView3];
}

- (void)setAudio:(XGTCAudio *)audio
{
    _audio = audio;

    self.audioPlayView1.filePath = audio.array[0];
    self.audioPlayView1.totalLength = audio.totalLength;
    self.audioPlayView1.leftLength = audio.totalLength;
    
    self.audioPlayView2.filePath = audio.array[1];
    self.audioPlayView2.totalLength = audio.totalLength;
    self.audioPlayView2.leftLength = audio.totalLength;
    
    self.audioPlayView3.filePath = audio.array[2];
    self.audioPlayView3.totalLength = audio.totalLength;
    self.audioPlayView3.leftLength = audio.totalLength;
    
    if ([self.audioPlayView1.filePath isEqualToString:[XGTCAVAudioManager sharedInstance].currentPlayingFilePath]) {
        //当前资源播放完毕后根据播放器的状态来决定此按钮的显示状态
        if ([[XGTCAVAudioManager sharedInstance].player isPlaying]) {
            self.audioPlayView1.state = 1;
        } else {
            self.audioPlayView1.state = 0;
        }
    } else {
        self.audioPlayView1.state = 0;
    }
    
    if ([self.audioPlayView2.filePath isEqualToString:[XGTCAVAudioManager sharedInstance].currentPlayingFilePath]) {
        //当前资源播放完毕后根据播放器的状态来决定此按钮的显示状态
        if ([[XGTCAVAudioManager sharedInstance].player isPlaying]) {
            self.audioPlayView2.state = 1;
        } else {
            self.audioPlayView2.state = 0;
        }
    } else {
        self.audioPlayView2.state = 0;
    }
    
    if ([self.audioPlayView3.filePath isEqualToString:[XGTCAVAudioManager sharedInstance].currentPlayingFilePath]) {
        //当前资源播放完毕后根据播放器的状态来决定此按钮的显示状态
        if ([[XGTCAVAudioManager sharedInstance].player isPlaying]) {
            self.audioPlayView3.state = 1;
        } else {
            self.audioPlayView3.state = 0;
        }
    } else {
        self.audioPlayView3.state = 0;
    }
}

@end
