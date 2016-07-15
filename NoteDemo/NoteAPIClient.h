//
//  NoteAPIClient.h
//  NoteDemo
//
//  Created by zhou_rui on 7/14/16.
//  Copyright © 2016 Rui Zhou. All rights reserved.
//

@import AFNetworking;

@interface NoteAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;

@end
