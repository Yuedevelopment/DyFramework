//
//  helloWorld.m
//  HelloDy
//
//  Created by Tangguo on 16/4/20.
//  Copyright © 2016年 Tangguo. All rights reserved.
//

#define UserCountkey @"UserCountkey"

#import "helloWorld.h"

@implementation helloWorld

-(NSInteger )helloWorldFunc;
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger count = [defaults integerForKey:UserCountkey];
    count++;
    [defaults setInteger:count forKey:UserCountkey];
    [defaults synchronize];
    
    return count;
}

@end
