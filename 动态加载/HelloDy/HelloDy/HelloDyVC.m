//
//  HelloDyVC.m
//  HelloDy
//
//  Created by hy on 16/5/7.
//  Copyright © 2016年 Tangguo. All rights reserved.
//

#import "HelloDyVC.h"

@interface HelloDyVC ()

@end

@implementation HelloDyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * lable = [[UILabel alloc] init];
    lable.text = @"我是动态调用VC";
    lable.frame = self.view.bounds;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor redColor];
    [self.view addSubview:lable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
