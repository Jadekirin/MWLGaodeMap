//
//  MWLMapSearchViewController.m
//  MWLGaodeMapDemo
//
//  Created by maweilong-PC on 2017/5/17.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "MWLMapSearchViewController.h"

@interface MWLMapSearchViewController () <AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

{
    double _Latitude;
    double _Longitude;
}

@property (nonatomic,strong) AMapSearchAPI *search;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSMutableArray *locationArray;



@end

@implementation MWLMapSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [[NSArray alloc] init];
    self.locationArray = [NSMutableArray array];
    [self setMapView];
//    [self setSearchMap];
    [self SetSearchTextField];
}

- (void)SetSearchTextField{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];//allocate titleView
//    UIColor *color =  self.navigationController.navigationBar.tintColor;
    [titleView setBackgroundColor:[UIColor clearColor]];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, 150, 30);
//    searchBar.backgroundColor = color;
//    searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
//    [titleView addSubview:searchBar];
    
    //Set to titleView
    self.navigationItem.titleView = searchBar;
    
    
//    CGFloat W = 200;
//    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth - W)/2, 80, W, 40)];
//    searchField.backgroundColor = [UIColor clearColor];
//    searchField.layer.borderColor = [UIColor grayColor].CGColor;
//    searchField.layer.borderWidth = 1.0;
//    searchField.placeholder = @"🔍输入要搜索的地点";
//    
//    [self.mapView addSubview:searchField];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar resignFirstResponder];
    [self setSearchMap:searchBar.text];
    
}



- (void)setSearchMap:(NSString*)keywords{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords = keywords;
    
//    request.keywords            = @"上海交通大学";
//    request.city                = @"上海";
//    request.types               = @"高等院校";
    request.requireExtension    = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    
    //发起搜索
    [self.search AMapPOIKeywordsSearch:request];
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }else{
        self.dataArray = response.pois;
        [self setTableView];
    }
    
    //解析response获取POI信息，具体解析见 Demo
}



#pragma mark - TableView
- (void)setTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight/3 * 2, kScreenWidth, kScreenHeight/3)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.mapView addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *mainCellIdentifier = @"mainCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    AMapPOI *pois = self.dataArray[indexPath.row];
    cell.textLabel.text = pois.name;
    cell.detailTextLabel.text = pois.address;
    
    if (pois.images.count != 0) {
        NSString *ImgStr = pois.images[0].url;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:ImgStr]];
    }
//    [self.locationArray addObject:pois.location];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMapPOI *pois = self.dataArray[indexPath.row];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = pois.location.latitude;
    coordinate.longitude = pois.location.longitude;
    
//    [self.mapView removeAnnotation:self.pointAnnotaiton];

//    if (self.pointAnnotaiton == nil)
//    {
        self.pointAnnotaiton = [[MAPointAnnotation alloc] init];
        [self.pointAnnotaiton setCoordinate:coordinate];
        
        [self.mapView addAnnotation:self.pointAnnotaiton];
//    }
   
    
    [self.mapView setCenterCoordinate:coordinate];
}



#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    //大头针
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout   = YES;//弹出气泡
        annotationView.animatesDrop     = YES;
        annotationView.draggable        = YES;//可以拖动
        annotationView.image            = [UIImage imageNamed:@"icon_location.png"];
        
        return annotationView;
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
