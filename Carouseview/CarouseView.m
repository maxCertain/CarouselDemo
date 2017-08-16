//
//  CarouseView.m
//  CarouselDemo
//
//  Created by liicon on 2017/6/23.
//  Copyright © 2017年 max. All rights reserved.
//

#import "CarouseView.h"
#import "CarouseImageCell.h"

@interface CarouseView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableview;
@property (nonatomic, strong) UIPageControl *pageCtrl;
@property (nonatomic, strong) NSArray *myDataSource;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CarouseView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self mainUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self mainUI];
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    
    if (_dataSource.count) {//在数据源中添加两张图片，造成循环的平滑过渡
        NSMutableArray *mut = [_dataSource mutableCopy];
        [mut addObject:[_dataSource firstObject]];
        [mut insertObject:[_dataSource lastObject] atIndex:0];
        self.myDataSource = [mut copy];
    }
    
    self.pageCtrl.numberOfPages = _dataSource.count;
    [self.tableview reloadData];
    self.tableview.contentOffset = CGPointMake(0, self.bounds.size.width);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [UIScreen mainScreen].bounds.size.width;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CarouseImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    UIImage *image = [self.myDataSource objectAtIndex:indexPath.row];
    if ([image isKindOfClass:[UIImage class]]) {
        cell.customImageView.image = image;
    }else if ([image isKindOfClass:[NSString class]]){
        NSString *url = (NSString *)image;
        if (_placehoder) {
            cell.customImageView.image = self.placehoder;
        }
        if ([url hasPrefix:@"http"]) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                cell.customImageView.image = image;
                NSMutableArray *mut = [self.myDataSource mutableCopy];
                [mut replaceObjectAtIndex:indexPath.row withObject:image];
                _myDataSource = mut;
            }
        }
    }
    return cell;
}

//拖拽的时候计时器停止 重新开始计时
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.autoScroll && self.timer) {
        [self.timer invalidate];
        [self scrollImage];
    }
}

//滑倒底部和头部的时候设置偏移，做成循环假象
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y >= (self.dataSource.count + 1) * self.bounds.size.width) {
        self.tableview.contentOffset = CGPointMake(0, self.bounds.size.width);
    }else if (scrollView.contentOffset.y <= 0){
        self.tableview.contentOffset = CGPointMake(0, self.dataSource.count* self.bounds.size.width);
    }
    NSInteger page = scrollView.contentOffset.y / self.bounds.size.width - 1;
    self.pageCtrl.currentPage = page;
    
}


/**
 是否允许自动循环

 @param autoScroll autoScroll description
 */
- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    if (autoScroll) {
        if (self.timer) {
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        }else{
            self.timer = [NSTimer timerWithTimeInterval:self.scrollInterval>0?self.scrollInterval:3.0 target:self selector:@selector(playImage) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        }
    }
}

//循环时间
- (void)setScrollInterval:(CGFloat)scrollInterval{
    _scrollInterval = scrollInterval;
    if (self.timer) {
        [self.timer invalidate];
    }
    if (!self.autoScroll) return;
    
    [self scrollImage];
}

- (void)mainUI{
    [self initTable];
    [self addSubview:self.pageCtrl];
}


/**
 设置自动滑动的事件间隔
 */
- (void)scrollImage{
    self.timer = [NSTimer timerWithTimeInterval:self.scrollInterval>0?self.scrollInterval:3.0 target:self selector:@selector(playImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)playImage{
    
    NSInteger page = self.tableview.contentOffset.y/self.bounds.size.width;
    CGPoint newPoint = CGPointMake(0, (page + 1) * self.bounds.size.width);
    [self.tableview setContentOffset:newPoint animated:true];
}

- (UIPageControl *)pageCtrl{
    if (_pageCtrl == nil) {
        _pageCtrl = [[UIPageControl alloc] init];
        _pageCtrl.hidesForSinglePage = YES;
        _pageCtrl.userInteractionEnabled = false;
    }
    return _pageCtrl;
}

- (void)initTable{
   
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.width) style:UITableViewStylePlain];
    
    self.tableview.transform = CGAffineTransformMakeRotation(-M_PI/2);
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.pagingEnabled = YES;
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.showsHorizontalScrollIndicator = NO;
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableview.bounces = NO;
    
    UINib *nib = [UINib nibWithNibName:@"CarouseImageCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self addSubview:self.tableview];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger page = self.tableview.contentOffset.y/self.bounds.size.width;
    [self.tableview setContentOffset:CGPointMake(0, (page + 1) * self.bounds.size.width) animated:YES];
    
    //先停止图片自动滑动 ，等设置完成偏移后再次自动滑动，避免旋转的时候出现自动滑动的冲突
    [self.timer invalidate];
    
    self.tableview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
 
    //重新设置自动滑动间隔
    [self scrollImage];
  
    self.pageCtrl.frame =CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
