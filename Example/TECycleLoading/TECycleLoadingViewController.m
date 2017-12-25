//
//  TECycleLoadingViewController.m
//  TECycleLoading
//
//  Created by bygd2014@sina.com on 12/25/2017.
//  Copyright (c) 2017 bygd2014@sina.com. All rights reserved.
//

#import "TECycleLoadingViewController.h"
#import <TECycleLoading/TECycleLoading.h>

@interface TECycleLoadingViewController ()

@end

@implementation TECycleLoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    TECycleLoading *loading = [[TECycleLoading alloc] init];
    loading.frame = CGRectMake(0, 0, 400, 400);
//    [lock performSelector:@selector(setParam: :) withObject:@"lineColor" withObject:@"#FF0000"];
    //    [lock performSelector:@selector(setParam: :) withObject:@"unchoosed" withObject:@"accountLock1.png"];
    //    [lock performSelector:@selector(setParam: :) withObject:@"choosed" withObject:@"accountLock2.png"];
    loading.backgroundColor = [UIColor redColor];
    [self.view addSubview:loading];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
