//
//  AppDelegate.h
//  HelloLoad
//
//  Created by Tangguo on 16/4/20.
//  Copyright © 2016年 Tangguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//获取framework具体地址
+(void) OnDlopenLoadAtPathAction1;

//把framework 添加到内存中
+(void) DlopenLoadDylibWithPath:(NSString *)path;
@end

