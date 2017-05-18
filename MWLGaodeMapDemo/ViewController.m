//
//  ViewController.m
//  MWLBDMapView
//
//  Created by maweilong-PC on 2017/5/16.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "ViewController.h"
#import "CircleLocationViewController.h"
#import "PinLocationViewController.h"
#import "MWLMapSearchViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dataArray = @[@"精度圈定位显示",@"大头针定位显示",@"关键字检索POI",@""];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
//    [self.tableView registerClass:[UITableView class] forCellReuseIdentifier:@"cellid"];
    
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
    

    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CircleLocationViewController *VC = [[CircleLocationViewController alloc] init];
        VC.title = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row == 1){
        PinLocationViewController *VC = [[PinLocationViewController alloc] init];
        VC.title = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row == 2){
        MWLMapSearchViewController *VC = [[MWLMapSearchViewController alloc] init];
        VC.title = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
    }
}


@end
