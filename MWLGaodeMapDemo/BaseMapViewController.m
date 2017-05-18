//
//  BaseMapViewController.m
//  MWLGaodeMapDemo
//
//  Created by maweilong-PC on 2017/5/17.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "BaseMapViewController.h"

@interface BaseMapViewController ()


@end

@implementation BaseMapViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.navigationController.toolbar.translucent   = YES;
//    self.navigationController.toolbarHidden         = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_locationManager startUpdatingLocation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //创建地图
//    [self setMapView];
}

- (void)setMapView{
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.zoomLevel = 18;//缩放等级
     [self.mapView setDelegate:self];
    _mapView.scaleOrigin = CGPointMake(15, 80);//比例尺位置
    _mapView.showsCompass = YES;//是否显示指南针
    _mapView.compassOrigin = CGPointMake(kScreenWidth - 75, 80);
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    self.mapView.mapType = MAMapTypeStandard;//地图的类型
    [self.view addSubview:_mapView];
    
    //定位管理类
    _locationManager = [[AMapLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];//定位精度
    //   定位超时时间，最低2s，此处设置为10s
    _locationManager.locationTimeout =10;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    _locationManager.reGeocodeTimeout = 10;
    //持续定位
    _locationManager.distanceFilter = 200;//设定定位的最小更新距离
    //    [_locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //连续定位是否返回逆地理信息
    [_locationManager setLocatingWithReGeocode:YES];
    //如果需要持续定位返回逆地理编码信息 需要做如下设置:
    [_locationManager startUpdatingLocation];
    
}



@end
