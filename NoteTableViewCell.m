//
//  NoteTableViewCell.m
//  NoteDemo
//
//  Created by zhou_rui on 7/14/16.
//  Copyright © 2016 Rui Zhou. All rights reserved.
//

#import "NoteTableViewCell.h"
#import "Note.h"

@implementation NoteTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:18.0f];
    self.detailTextLabel.numberOfLines = 0;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return self;
}

- (void)setNote:(Note *)note {
    _note = note;
    self.textLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_note.noteID];
    self.detailTextLabel.text = _note.noteContent;
    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithNote:(Note *)note {
    return (CGFloat)fmaxf(70.0f, (float)[self detailTextHeight:note.noteContent] + 45.0f);
}

+ (CGFloat)detailTextHeight:(NSString *)text {
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(240.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]} context:nil];
    return rectToFit.size.height;
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(20.0f, 10.0f, 240.0f, 20.0f);
    
    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 30.0f);
    CGFloat calculatedHeight = [[self class] detailTextHeight:self.note.noteContent];
    detailTextLabelFrame.size.height = calculatedHeight;
    self.detailTextLabel.frame = detailTextLabelFrame;
}

@end
