//
//  DetailViewController.h
//  NoteDemo
//
//  Created by zhou_rui on 7/13/16.
//  Copyright © 2016 Rui Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

