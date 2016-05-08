//
//  ViewController.m
//  HelloLoad
//
//  Created by Tangguo on 16/4/20.
//  Copyright © 2016年 Tangguo. All rights reserved.
//

#import "ViewController.h"
#import <dlfcn.h>
#import "LoadFileClient.h"
#import "ZipArchive.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //https://dn-heyue.qbox.me/HelloDy.framework.zip
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"调用frameWork" forState:UIControlStateNormal];
    button.frame = CGRectMake(50, 50, 140, 60);
    button.backgroundColor = [UIColor orangeColor];
    button.center = self.view.center;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(actionFrameWork) forControlEvents:UIControlEventTouchUpInside];
    
    //下载 framework
    LoadFileClient *fileLoadClient = [[LoadFileClient alloc] initWithStartCache:@"https://dn-heyue.qbox.me/HelloDy.framework.zip" Success:^(id result) {
        
        NSLog(@"下载完成");
        NSString *documentDirectory = NSTemporaryDirectory();
        NSString *documentsPath = [documentDirectory stringByAppendingString:@"tempFramework.zip"];
        //写入沙盒
        BOOL suscess = [result writeToFile:documentsPath atomically:YES];
        if (suscess) {
            
            ZipArchive *zip = [[ZipArchive alloc] init];
            
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString *documentDirectory = nil;
            if ([paths count] != 0) {
                
                documentDirectory = [paths objectAtIndex:0];
                documentDirectory = [documentDirectory stringByAppendingString:@"/"];
                
                //解压缩
                [zip UnzipOpenFile:documentsPath];
                [zip UnzipFileTo:documentDirectory overWrite:YES];
                
                //注入内存
                [AppDelegate OnDlopenLoadAtPathAction1];
            }
            NSLog(@"documentDirectory=%@",documentDirectory);
            
        }
        
    } failure:^(NSInteger statuscode, NSString *errordes) {
        
    }];
    
    //开始下载
    [fileLoadClient startCache];
}


//点击调用
- (void)actionFrameWork {
    
    /*
     NSClassFromString  字符串转类
     performSelector 利用动态调用的方式调用方法
     */
    
    //字符串转换成类
    Class rootClass = NSClassFromString(@"helloWorld");
    
    if (rootClass) {
        
        id object = [[rootClass alloc] init];
        if ([object respondsToSelector:@selector(helloWorldFunc)]) {
            
            NSInteger count = [object performSelector:@selector(helloWorldFunc)];
            NSLog(@"count=%ld",(long)count);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Count" message:[NSString stringWithFormat:@"%d",count] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
