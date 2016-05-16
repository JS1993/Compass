//
//  ViewController.m
//  Compass
//
//  Created by  江苏 on 16/5/16.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

/*位置管理者*/
@property(strong,nonatomic)CLLocationManager* CLManager;

@property (strong, nonatomic) IBOutlet UIImageView *compassImageV;

@end

@implementation ViewController

#pragma mark--懒加载
/*位置管理者懒加载*/
-(CLLocationManager *)CLManager
{
    if (_CLManager==nil) {
        _CLManager=[[CLLocationManager alloc]init];
        _CLManager.delegate=self;
    }
    return _CLManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.CLManager startUpdatingHeading];
}

- (void)locationManager:(CLLocationManager *)manager  didUpdateHeading:(CLHeading *)newHeading{
    
    //如果当前设备的朝向信息不可用，直接返回
    if (newHeading.headingAccuracy<0) return;
    
    //获取设备的朝向角度
    CLLocationDirection direction=newHeading.magneticHeading;
    
    CGFloat angle=direction/180.0*M_PI;
    
    //设置旋转动画
    [UIView animateWithDuration:0.5 animations:^{
        
        self.compassImageV.transform=CGAffineTransformMakeRotation(-angle);
        
    }];
}
@end
