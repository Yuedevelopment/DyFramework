//
//  AppDelegate.m
//  HelloLoad
//
//  Created by Tangguo on 16/4/20.
//  Copyright © 2016年 Tangguo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HelloLoad-Swift.h" //oc混编swift
#import <dlfcn.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //SwiftViewController *vc = [[SwiftViewController alloc] init];

    ViewController *vc = [[ViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.toolbarHidden = true;
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//获取framework具体地址
+(void) OnDlopenLoadAtPathAction1
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory = nil;
    if ([paths count] != 0)
        documentDirectory = [paths objectAtIndex:0];
    
    NSString *documentsPath = [NSString stringWithFormat:@"%@/HelloDy.framework/HelloDy",documentDirectory];
    [self DlopenLoadDylibWithPath:documentsPath];
}

//把framework 添加到打开添加到运行工程中
+(void) DlopenLoadDylibWithPath:(NSString *)path;
{
    /*
     　RTLD_LAZY 暂缓决定，等有需要时再解出符号
     　RTLD_NOW 立即决定，返回前解除所有未决定的符号。
     */
    
    void *libHandle = NULL;
    libHandle = dlopen([path cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
    if (libHandle == NULL) {
        char *error = dlerror();
        NSLog(@"dlopen error: %s", error);
    } else {
        NSLog(@"dlopen load framework success.");
    }
    
}


@end
