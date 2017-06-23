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


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CarouseView *carouseView = [[CarouseView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200)];
//    carouseView.dataSource = [self getMyDatas];
    
    [self.view addSubview:carouseView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSMutableArray *)getMyDatas{
    
    NSMutableArray *mut = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 7; i++) {
        NSString *imageName = [NSString stringWithFormat:@"plan0%d.jpg",i];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [mut addObject:image];
        }
    }
    return mut;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
