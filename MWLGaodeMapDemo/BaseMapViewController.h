//
//  BaseMapViewController.h
//  MWLGaodeMapDemo
//
//  Created by maweilong-PC on 2017/5/17.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseMapViewController : UIViewController <AMapLocationManagerDelegate,MAMapViewDelegate>

{
    MAUserLocationRepresentation *_Representation;//用户位置显示样式控制
    AMapLocationManager *_locationManager;//
}

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;//创建大头针
- (void)setMapView;

@end
