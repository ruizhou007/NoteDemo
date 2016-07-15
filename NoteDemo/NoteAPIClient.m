//
//  NoteAPIClient.m
//  NoteDemo
//
//  Created by zhou_rui on 7/14/16.
//  Copyright © 2016 Rui Zhou. All rights reserved.
//

#import "NoteAPIClient.h"
static NSString * const NoteAPIBaseURLString = @"http://notedemo.azurewebsites.net";

@implementation NoteAPIClient



+ (instancetype)sharedClient {
    static NoteAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NoteAPIClient alloc] initWithBaseURL:[NSURL URLWithString:NoteAPIBaseURLString]];
        //_sharedClient.requestSerializer = [AFHTTPRequestSerializer new];
        
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil ];
    });
    
    return _sharedClient;
}

@end
