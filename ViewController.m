//
//  ViewController.m
//  CarouselDemo
//
//  Created by liicon on 2017/6/23.
//  Copyright © 2017年 max. All rights reserved.
//

#import "ViewController.h"
#import "CarouseView.h"

@interface ViewController ()

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) CarouseView *carouseView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.carouseView.placehoder = [UIImage imageNamed:@"D9oa-fyitapv7158583.jpg"];
    
    [self.view addSubview:self.carouseView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (CarouseView *)carouseView{
    if (_carouseView == nil) {
        _carouseView = [[CarouseView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200)];
        _carouseView.autoScroll = YES;
        _carouseView.dataSource = [self getMyDatas];
    }
    return _carouseView;
}

- (NSMutableArray *)getMyDatas{
    
    NSMutableArray *mut = [[NSMutableArray alloc] init];
    
//    for (int i = 1; i <= 7; i++) {
//        NSString *imageName = [NSString stringWithFormat:@"plan0%d.jpg",i];
//        UIImage *image = [UIImage imageNamed:imageName];
//        if (image) {
//            [mut addObject:image];
//        }
//    }
    [mut addObject:@"https://f12.baidu.com/it/u=1968265655,3732795756&fm=72"];
    [mut addObject:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1108586549,2564303919&fm=200&gp=0.jpg"];
    [mut addObject:@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3654209710,2251273458&fm=26&gp=0.jpg"];
    return mut;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.carouseView.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
