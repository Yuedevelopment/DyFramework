//
//  LoadFileClient.h
//  HelloLoad
//
//  Created by Tangguo on 16/5/6.
//  Copyright © 2016年 Tangguo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void ( ^LFCSuccessBlock ) (id result );
typedef void ( ^LFCFailureBlock ) (NSInteger statuscode, NSString *errordes);

@interface LoadFileClient : NSObject
{
    int64_t _bytesTotal;
    NSString *_strURL;
}

@property(nonatomic, copy) LFCSuccessBlock successBlock;
@property(nonatomic, copy) LFCFailureBlock failureBlock;
@property(nonatomic, retain) NSURLConnection *conn;
@property(nonatomic, retain) NSMutableData *buffer;

-(instancetype) initWithStartCache:(NSString *)strURL
                           Success:(LFCSuccessBlock)success
                           failure:(LFCFailureBlock)failure;
-(void)startCache;
-(void) cancel;


@end
