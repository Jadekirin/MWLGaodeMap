//
//  CircleLocationViewController.m
//  MWLGaodeMapDemo
//
//  Created by maweilong-PC on 2017/5/17.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "CircleLocationViewController.h"

@interface CircleLocationViewController ()

@end

@implementation CircleLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMapView];
    [self setLocationManager];
}

- (void)setLocationManager{

    //如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    self.mapView.showsUserLocation = YES;
    
//    self.mapView.mapType = MAMapTypeStandard;//地图的类型
    
    
    
    
    
    //用户位置显示样式控制
    //    [self setUserLocationRepresentation];
    
    
}


#pragma mark - 用户位置显示样式控制
- (void)setUserLocationRepresentation{
    _Representation = [[MAUserLocationRepresentation alloc] init];
    //    _Representation.showsAccuracyRing = NO;//精度圈是否显示，默认YES
        _Representation.showsHeadingIndicator = YES;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)
    //    _Representation.fillColor = [UIColor redColor];//精度圈填充颜色
    _Representation.strokeColor = [UIColor blueColor];//精度圈 边线颜色
    _Representation.lineWidth = 2;//精度圈边线宽度
    //    _Representation.enablePulseAnnimation = NO;//内部蓝色圆点是否使用律动效果, 默认YES
    //    _Representation.locationDotBgColor = [UIColor greenColor];////定位点背景色，不设置默认白色
    _Representation.locationDotFillColor = [UIColor grayColor];//定位点蓝色圆点颜色，不设置默认蓝色
    _Representation.image = [UIImage imageNamed:@""];//定位图标, 与蓝色原点互斥
    
    //执行
    [self.mapView updateUserLocationRepresentation:_Representation];
    
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
        
    }
   
}



@end
