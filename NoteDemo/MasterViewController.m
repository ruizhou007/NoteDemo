//
//  MasterViewController.m
//  NoteDemo
//
//  Created by zhou_rui on 7/13/16.
//  Copyright © 2016 Rui Zhou. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Note.h"
#import "NoteTableViewCell.h"
#import "NoteAPIClient.h"
#import "DetailViewController.h"

@import AFNetworking;

@interface MasterViewController ()

@property NSMutableArray *objects;
@property (readwrite, nonatomic, strong) NSMutableArray *notes;

@end

@implementation MasterViewController

- (void)reload:(__unused id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSURLSessionTask *task = [Note globalNotesWithBlock:^(NSArray *notes, NSError *error) {
        if (!error) {
            self.notes = [NSMutableArray arrayWithArray:notes];
            [self.tableView reloadData];
        }else{
            NSLog(@"AADFGHJ%@",error);
        }
    }];
    
    [self.refreshControl setRefreshingWithStateOfTask:task];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;


    
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 100.0f)];
    [self.refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];
    
    self.tableView.rowHeight = 70.0f;
    
    //[self reload:nil];
 

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reload:nil];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.notes) {
        self.notes = [[NSMutableArray alloc] init];
    }
    [self performSegueWithIdentifier:@"Add" sender:self];

}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
       Note *selected = [self.notes objectAtIndex:indexPath.row];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.isAdding = NO;
        controller.note = selected;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }else if ([[segue identifier] isEqualToString:@"Add"]) {
        Note *created = [[Note alloc] initWithAttributes:@{@"note_id":@1,@"note_content":@""}];
        
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.noteIDLabel.hidden = YES;
        controller.isAdding = YES;
        controller.note = created;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)[self.notes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[NoteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.note = self.notes[(NSUInteger)indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *deleted = [self.notes objectAtIndex:indexPath.row];
        [deleted DeleteNote];
        
        [self.notes removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (CGFloat)tableView:(__unused UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NoteTableViewCell heightForCellWithNote:self.notes[(NSUInteger)indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    
    
    
}


#pragma mark - Data 


@end
