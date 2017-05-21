//
//  SelectLocationMapController.m
//  移动掌控
//
//  Created by 李昊泽 on 17/1/11.
//  Copyright © 2017年 dianbo. All rights reserved.
//

#import "SelectLocationMapController.h"
#import "UIImage+WantImage.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface SelectLocationMapController ()<MKMapViewDelegate, CLLocationManagerDelegate > {
    MKMapView *_mapView;
    CLLocationManager *_locationManger;
    UILabel *_topLabel;
    UILabel *_bottomLabel;
    UIImageView *_selectImageView;
    NSString *_address;
}

/** 反地理编码  */
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation SelectLocationMapController
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#pragma mark - initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMapView];
   
    [self setupBottomView];
   
    [self setupLocation];
    
    [self setupLocationSelfBtn];
    
    [self setupSelectImageView];
    
    self.navigationItem.title = @"地图选点";
    
}

- (void)setupMapView
{
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64 * 2)];
    _mapView = mapView;
    [self.view addSubview:mapView];
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    mapView.showsCompass = NO;
    mapView.userTrackingMode = MKUserTrackingModeFollow;
    
}

- (void)setupBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight - 64, KScreenWidth, 64)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIView *vericalLine = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth - 65, 15, 1, 64 - 15 * 2)];
    vericalLine.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:vericalLine];
    
    UIButton *certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [certainBtn setTitle:@"确定" forState:0];
    [certainBtn setTitleColor:ZYColor(76, 191, 164) forState:0];
    certainBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    certainBtn.frame = CGRectMake(KScreenWidth - 64, 0, 64, 64);
    [bottomView addSubview:certainBtn];
    [certainBtn addTarget:self action:@selector(certainSelectLocation) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.frame = CGRectMake(12, 0, KScreenWidth - 100, 32);
    topLabel.numberOfLines = 1;
    [bottomView addSubview:topLabel];
    _topLabel = topLabel;
    
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.frame = CGRectMake(12, 32, KScreenWidth - 100, 32);
    bottomLabel.numberOfLines = 1;
    [bottomView addSubview:bottomLabel];
    bottomLabel.textColor = [UIColor lightGrayColor];
    bottomLabel.font = [UIFont systemFontOfSize:13];
    _bottomLabel = bottomLabel;
    
    
}

- (void)setupLocation
{
    _locationManger = [[CLLocationManager alloc] init];
    _locationManger.delegate = self;
    _locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [_locationManger startUpdatingLocation];

}

 -(void)setupLocationSelfBtn
{
    //添加定位按钮
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locationBtn.backgroundColor = [UIColor whiteColor];
    [locationBtn setImage:[[UIImage imageNamed:@"location_point"] getWantImageWithSize:CGSizeMake(17, 17)] forState:0];
    [_mapView addSubview:locationBtn];
    locationBtn.layer.borderWidth = 1;
    locationBtn.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    locationBtn.layer.cornerRadius = 1;
    locationBtn.frame = CGRectMake(8, CGRectGetHeight(_mapView.frame) - 40, 30, 30);
    [locationBtn addTarget:self action:@selector(locationSelf) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupSelectImageView
{
    UIImage *image = [[UIImage imageNamed:@"地址选择"] getWantImageWithSize:CGSizeMake(20, 20)];
    _selectImageView = [[UIImageView alloc] initWithImage:image];
    
    _selectImageView.zy_higth = 30;
    _selectImageView.zy_width = 30;
    _selectImageView.zy_centerX = _mapView.zy_centerX;
    _selectImageView.zy_centerY = _mapView.zy_centerY - 0.5*_selectImageView.zy_higth;
    
    [self.view addSubview:_selectImageView];
}

#pragma mark - Selector
//定位
- (void)locationSelf
{
    [_locationManger stopUpdatingLocation];
    [_locationManger startUpdatingLocation];
}

//选择地址
- (void)certainSelectLocation
{
    if (self.certainBtnClick) {
        self.certainBtnClick(_address);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    
}
//- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView
//{
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.004, 0.004);
//    MKCoordinateRegion region = MKCoordinateRegionMake(mapView.userLocation.coordinate, span);
//    [_mapView setRegion:region];
//    
//    [self.geocoder reverseGeocodeLocation:mapView.userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        CLPlacemark *mark = placemarks.firstObject;
//        _address = [NSString stringWithFormat:@"%@%@%@%@", [self handleNullString:mark.administrativeArea], [self handleNullString:mark.locality], [self handleNullString:mark.subLocality], [self handleNullString:mark.name]];;
//        _topLabel.text = [NSString stringWithFormat:@"%@%@%@%@", [self handleNullString:mark.administrativeArea], [self handleNullString:mark.locality], [self handleNullString:mark.subLocality], [self handleNullString:mark.name]];
//        _bottomLabel.text = [NSString stringWithFormat:@"%@", mark.name];
//    }];
//}


- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    _topLabel.text = @"定位中";
    _bottomLabel.text = @"";
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CLLocation *clLocation = [[CLLocation alloc] initWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
    
    [self.geocoder reverseGeocodeLocation:clLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *mark = placemarks.firstObject;
        _address = [NSString stringWithFormat:@"%@%@%@%@", [self handleNullString:mark.administrativeArea], [self handleNullString:mark.locality], [self handleNullString:mark.subLocality], [self handleNullString:mark.name]];
        _topLabel.text = [NSString stringWithFormat:@"%@%@%@%@", [self handleNullString:mark.administrativeArea], [self handleNullString:mark.locality], [self handleNullString:mark.subLocality], [self handleNullString:mark.name]];
        _bottomLabel.text = [NSString stringWithFormat:@"%@", mark.name];
    }];
    
    [self imageViewAnimate];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.004, 0.004);
    MKCoordinateRegion region = MKCoordinateRegionMake(_mapView.userLocation.coordinate, span);
    [_mapView setRegion:region];
    
    [_locationManger stopUpdatingLocation];
}

#pragma mark - other
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (NSString *)handleNullString:(NSString *)nullString
{
    if (nullString == nil) {
        return @"";
    }
    return nullString;
}

- (void)imageViewAnimate
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint center = _selectImageView.center;
                         center.y -= 20;
                         [_selectImageView setCenter:center];}
                     completion:nil];
    
    [UIView animateWithDuration:0.45
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGPoint center = _selectImageView.center;
                         center.y += 20;
                         [_selectImageView setCenter:center];}
                     completion:nil];
    
}

#pragma mark - Lazy
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

@end
