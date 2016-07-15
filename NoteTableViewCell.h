//
//  NoteTableViewCell.h
//  NoteDemo
//
//  Created by zhou_rui on 7/14/16.
//  Copyright © 2016 Rui Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Note;

@interface NoteTableViewCell : UITableViewCell

@property (nonatomic, strong) Note *note;

+ (CGFloat)heightForCellWithNote:(Note *)note;

@end
