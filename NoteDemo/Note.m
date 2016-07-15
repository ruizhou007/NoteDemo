//
//  Note.m
//  NoteDemo
//
//  Created by zhou_rui on 7/14/16.
//  Copyright © 2016 Rui Zhou. All rights reserved.
//

#import "Note.h"
#import "NoteAPIClient.h"


@implementation Note

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.noteID = (NSUInteger)[[attributes valueForKeyPath:@"note_id"] integerValue];
    NSLog(@"Note id is %lu", (unsigned long)self.noteID);
    self.noteContent = [attributes valueForKeyPath:@"note_content"];
    NSLog(@"Note is %@", self.noteContent);
    
    return self;
}

+ (NSURLSessionDataTask *)globalNotesWithBlock:(void (^)(NSArray *notes, NSError *error))block {
    
    return [[NoteAPIClient sharedClient] GET:@"notelist" parameters:nil progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        NSLog(@"Status is %li",(long)response.statusCode);
        NSLog(@"Content Length is %li",(long)response.expectedContentLength);
        NSLog(@"URL is %ld",(long)response.URL);
        NSLog(@"Received json is %@",JSON);
        NSLog(@"Class is %@", [JSON class]);
       
        NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
        [mutaArray addObjectsFromArray:JSON];
        NSLog(@"mutaArray is %@", mutaArray);
        NSMutableArray *mutableNotes = [NSMutableArray arrayWithCapacity:[mutaArray count]];
        for (NSDictionary *attributes in mutaArray) {
            Note *note = [[Note alloc] initWithAttributes:attributes];
            [mutableNotes addObject:note];
        }
       
        if (block) {
            block([NSArray arrayWithArray:mutableNotes], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        NSLog(@"Status%li",(long)response.statusCode);
        if (block) {
            block([NSArray array], error);
        }
    }];
}

- (NSURLSessionDataTask *)DeleteNote {
    
    return [[NoteAPIClient sharedClient] DELETE:@"note" parameters:@{@"note_id":@(self.noteID)} success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        NSLog(@"Status is %li",(long)response.statusCode);
        NSLog(@"Content Length is %li",(long)response.expectedContentLength);
        NSLog(@"URL is %@",response.URL);
        NSLog(@"Received json is %@",JSON);
        NSLog(@"Class is %@", [JSON class]);
        
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        NSLog(@"Status%li",(long)response.statusCode);
    }];
}

+ (NSURLSessionDataTask *)globalAddNoteWithContent:(NSString*)content{
    
    return [[NoteAPIClient sharedClient] POST:@"note" parameters:@{@"note_content":content} progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        NSLog(@"Status is %li",(long)response.statusCode);
        NSLog(@"Content Length is %li",(long)response.expectedContentLength);
        NSLog(@"URL is %@",response.URL);
        NSLog(@"Received json is %@",JSON);
        NSLog(@"Class is %@", [JSON class]);
        
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        NSLog(@"Status%li",(long)response.statusCode);
    }];
}

- (NSURLSessionDataTask *)modifyNoteWithContent:(NSString*)content{
    return [[NoteAPIClient sharedClient] PUT:@"note" parameters:@{@"note_id":@(self.noteID),@"note_content":content} success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        NSLog(@"Status is %li",(long)response.statusCode);
        NSLog(@"Content Length is %li",(long)response.expectedContentLength);
        NSLog(@"URL is %@",response.URL);
        NSLog(@"Received json is %@",JSON);
        NSLog(@"Class is %@", [JSON class]);
        
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        NSLog(@"Status%li",(long)response.statusCode);
    }];
}

@end
