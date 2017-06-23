//
//  CarouseView.m
//  CarouselDemo
//
//  Created by liicon on 2017/6/23.
//  Copyright © 2017年 max. All rights reserved.
//

#import "CarouseView.h"
#import "ImageCell.h"

@interface CarouseView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableview;
@property (nonatomic, strong) UIPageControl *pageCtrl;

@end

@implementation CarouseView

- (instancetype)init{
    if (self = [super init]) {
        [self mainUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self mainUI];
    }
    return self;
}



- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
//    self.pageCtrl.numberOfPages = _dataSource.count;
//    [self.tableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.width;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
//    
//    UIImage *image = [self.dataSource objectAtIndex:indexPath.row];
//    if ([image isKindOfClass:[UIImage class]]) {
//        cell.customImageView.image = image;
//    }
    return cell;
}

- (void)mainUI{
    [self initTable];
    [self addSubview:self.pageCtrl];
}

- (UIPageControl *)pageCtrl{
    if (_pageCtrl == nil) {
        _pageCtrl = [[UIPageControl alloc] init];
        _pageCtrl.hidesForSinglePage = YES;
    }
    return _pageCtrl;
}

- (void)initTable{
    self.tableview = [[UITableView alloc] init];
    
    self.tableview.transform = CGAffineTransformMakeRotation(-M_PI/2);
    self.tableview.backgroundColor = [UIColor redColor];
    [self addSubview:self.tableview];
    
    
    UINib *nib = [UINib nibWithNibName:@"ImageCell" bundle:nil];
    [self.tableview registerNib:nib forHeaderFooterViewReuseIdentifier:@"cell"];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
//    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    self.tableview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.pageCtrl.frame =CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 30);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
