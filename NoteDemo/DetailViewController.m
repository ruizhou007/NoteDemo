//
//  DetailViewController.m
//  NoteDemo
//
//  Created by zhou_rui on 7/13/16.
//  Copyright © 2016 Rui Zhou. All rights reserved.
//

#import "DetailViewController.h"
#import "Note.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UITextView *noteContentTextView;
@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;

@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.noteIDLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.note.noteID];
    self.noteContentTextView.text = self.note.noteContent;
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = addButton;
    if (_isAdding) {
        self.noteIDLabel.hidden = YES;
        self.instructionLabel.text = @"Note";
    }
  
}

-(void)save{
    if (self.isAdding == YES) {
        [Note globalAddNoteWithContent:self.noteContentTextView.text];
        
    }else{
        
    [self.note modifyNoteWithContent:self.noteContentTextView.text];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(NSDate *)newDetailItem {
    
}

@end
