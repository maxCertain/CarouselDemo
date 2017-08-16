//
//  CarouseView.h
//  CarouselDemo
//
//  Created by liicon on 2017/6/23.
//  Copyright © 2017年 max. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouseView : UIView

@property(nonatomic,strong) NSArray *dataSource;

@property(nonatomic, assign) CGFloat scrollInterval;//滑动的时间
@property(nonatomic, assign) BOOL autoScroll;

@property(nonatomic, strong) UIImage *placehoder;//当传入的是url时的存冲图；

@end
