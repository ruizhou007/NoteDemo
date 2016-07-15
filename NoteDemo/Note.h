//
//  Note.h
//  NoteDemo
//
//  Created by zhou_rui on 7/14/16.
//  Copyright © 2016 Rui Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic, assign) NSUInteger noteID;
@property (nonatomic, strong) NSString  *noteContent;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
- (NSURLSessionDataTask *)DeleteNote;
+ (NSURLSessionDataTask *)globalNotesWithBlock:(void (^)(NSArray *notes, NSError *error))block;
+ (NSURLSessionDataTask *)globalAddNoteWithContent:(NSString*)content;
- (NSURLSessionDataTask *)modifyNoteWithContent:(NSString*)content;

@end

@interface Note (NSCoding) <NSSecureCoding>

@end
