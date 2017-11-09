
#import "XGTCKeYuanHistoryViewController.h"
#import "XGTCKeYuanHistoryCell.h"
#import "XGTCAVAudioManager.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define XGTCKeYuanHistoryCellIdentifier @"XGTCKeYuanHistoryCellIdentifier"

@interface XGTCKeYuanHistoryViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XGTCKeYuanHistoryViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[XGTCAVAudioManager sharedInstance] stop];
    [XGTCAVAudioManager sharedInstance].player = nil;
    [XGTCAVAudioManager sharedInstance].currentPlayingFilePath = @"";
    [XGTCAVAudioManager sharedInstance].currentPlayingFilePath = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EmptyPlaying" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *lefttBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<-" style:UIBarButtonItemStylePlain target:self action:@selector(popToLastPage)];
    self.navigationItem.leftBarButtonItem = lefttBarButtonItem;
    
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    
    [self loadLocalData];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:@"PlayRefresh" object:nil];
}

- (NSString *)getFilePathWithIndex:(NSInteger)index
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *folderName = [path stringByAppendingPathComponent:@"PlayTest"];
    NSString *fileName = [NSString stringWithFormat:@"/Visitor%ld.wav", (long)index];
    NSString *filePath = [folderName stringByAppendingString:fileName];
    return filePath;
}

- (void)loadLocalData
{
    XGTCAudio *audio1 = [[XGTCAudio alloc] init];
    audio1.array = @[[self getFilePathWithIndex:10], [self getFilePathWithIndex:11], [self getFilePathWithIndex:12]];
    audio1.totalLength = 9;
    
    XGTCAudio *audio2 = [[XGTCAudio alloc] init];
    audio2.array = @[[self getFilePathWithIndex:20], [self getFilePathWithIndex:21], [self getFilePathWithIndex:22]];
    audio2.totalLength = 9;
    
    XGTCAudio *audio3 = [[XGTCAudio alloc] init];
    audio3.array = @[[self getFilePathWithIndex:30], [self getFilePathWithIndex:31], [self getFilePathWithIndex:32]];
    audio3.totalLength = 9;
    
    XGTCAudio *audio4 = [[XGTCAudio alloc] init];
    audio4.array = @[[self getFilePathWithIndex:40], [self getFilePathWithIndex:41], [self getFilePathWithIndex:42]];
    audio4.totalLength = 9;
    
    XGTCAudio *audio5 = [[XGTCAudio alloc] init];
    audio5.array = @[[self getFilePathWithIndex:50], [self getFilePathWithIndex:51], [self getFilePathWithIndex:52]];
    audio5.totalLength = 9;
    
    XGTCAudio *audio6 = [[XGTCAudio alloc] init];
    audio6.array = @[[self getFilePathWithIndex:60], [self getFilePathWithIndex:61], [self getFilePathWithIndex:62]];
    audio6.totalLength = 9;
    
    NSArray *array = @[audio1, audio2, audio3, audio4, audio5, audio6];
    [self.dataSource addObjectsFromArray:array];
}

// 通知刷新
- (void)refreshTable
{
    [self.tableView reloadData];
}

// 退出并返回首页
- (void)popToLastPage
{
    [[XGTCAVAudioManager sharedInstance] stop];
    [XGTCAVAudioManager sharedInstance].player = nil;
    [XGTCAVAudioManager sharedInstance].currentPlayingFilePath = @"";
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView registerClass:[XGTCKeYuanHistoryCell class] forCellReuseIdentifier:XGTCKeYuanHistoryCellIdentifier];
    XGTCKeYuanHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:XGTCKeYuanHistoryCellIdentifier];
    if (nil == cell) {
        cell = [[XGTCKeYuanHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XGTCKeYuanHistoryCellIdentifier];
    }
    cell.audio = self.dataSource[indexPath.row];
    return cell;
}

@end
