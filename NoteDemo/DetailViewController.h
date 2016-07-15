//
//  DetailViewController.h
//  NoteDemo
//
//  Created by zhou_rui on 7/13/16.
//  Copyright © 2016 Rui Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Note;

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *noteIDLabel;
@property (strong, nonatomic) Note *note;
@property BOOL isAdding;


@end

