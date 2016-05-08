//
//  LoadFileClient.m
//  HelloLoad
//
//  Created by Tangguo on 16/5/6.
//  Copyright © 2016年 Tangguo. All rights reserved.
//

#import "LoadFileClient.h"

@implementation LoadFileClient

-(instancetype) initWithStartCache:(NSString *)strURL
                           Success:(LFCSuccessBlock)success
                           failure:(LFCFailureBlock)failure
{
    self = [super init];
    if (self) {
        self.successBlock = success;
        self.failureBlock = failure;
        _strURL = strURL;
        _buffer = [[NSMutableData alloc] init];
    }
    return self;
}

-(void) connCancel
{
    if (self.conn) {
        [self.conn cancel];
        self.conn = nil;
    }
}

-(void) cancel
{
    [self connCancel];
    self.successBlock = nil;
    self.failureBlock = nil;
}

-(void) startCache
{
    [self connCancel];
    
    [_buffer setLength:0];
    
    NSURL *url                      = [[NSURL alloc] initWithString:_strURL];
    NSMutableURLRequest *urlReq     = [[NSMutableURLRequest alloc] initWithURL:url];
    urlReq.timeoutInterval          = 20.0;
    urlReq.HTTPMethod               = @"GET";
    self.conn = [NSURLConnection connectionWithRequest:urlReq delegate:self];
}

#pragma mark NSURLConnection Delegate
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //NSLog(@"connection fail.");
    if (self.failureBlock) {
        self.failureBlock(404, error.description);
    }
    self.successBlock = nil;
    self.failureBlock = nil;
    self.conn = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if(httpResponse && [httpResponse respondsToSelector:@selector(allHeaderFields)]){
        NSDictionary *httpResponseHeaderFields = [httpResponse allHeaderFields];
        
        _bytesTotal = [[httpResponseHeaderFields objectForKey:@"Content-Length"] longLongValue];
        
        //NSLog(@"%lld", _bytesTotal);
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_buffer appendData:data];
    
    int nPercent = (((float)_buffer.length / (float)_bytesTotal) * 100);
    if (nPercent >= 100) {
        if (self.successBlock) {
            self.successBlock(_buffer);
        }
        self.successBlock = nil;
        self.failureBlock = nil;
        self.conn = nil;
    }
}


@end
