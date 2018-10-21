//
//  ViewController.m
//  RunLoop
//
//  Created by LYH on 2018/10/21.
//  Copyright © 2018年 LYH-1140663172@qq.com. All rights reserved.
//

#import "ViewController.h"
#import "NSTimerViewController.h"
#import "ShowImageViewController.h"
#import "ResidentThreadViewController.h"
#import "GCDTimerViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray<NSString *> *titleArray;

@end
static NSString *const runLoopID = @"UITableViewCell_runLoop";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"RunLoop知识";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleArray = [NSArray arrayWithObjects:@"NSTimer定时器",@"图片展示and监听RunLoop的状态",@"常驻线程",@"GCD定时器", nil];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 45;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:runLoopID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:runLoopID];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSTimerViewController *timerVC = [[NSTimerViewController alloc] init];
    ShowImageViewController *showVC = [[ShowImageViewController alloc] init];
    ResidentThreadViewController *threadVC = [[ResidentThreadViewController alloc] init];
    GCDTimerViewController *gcdTimerVC = [[GCDTimerViewController alloc] init];
    NSArray *vcArray = @[timerVC,showVC,threadVC,gcdTimerVC];
    [self.navigationController pushViewController:vcArray[indexPath.row] animated:YES];
}

@end
