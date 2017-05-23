//
//  TableViewController.m
//  LetsGOApp
//
//  Created by Marbet Ramon on 5/15/17.
//  Copyright © 2017 Ramon. All rights reserved.
//


#import "TableViewController.h"
#import "DetailViewController.h"
#import "Location.h"
#import "JSONLoader.h"

@interface TableViewController ()

@end

#define GET_DATA_URL @"http://demo3842168.mockable.io/api/stores/lestgoapp"

@implementation TableViewController {
   
    NSArray *_locations;
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"LetsGO App";
    
    JSONLoader *jsonLoader = [[JSONLoader alloc] init];
    NSURL *url = [NSURL URLWithString:GET_DATA_URL];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _locations = [jsonLoader locationsFromJSONurl:url];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
   
    });
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *vc = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    vc.location = [_locations objectAtIndex:indexPath.row];
}



#pragma mark - Table View Controller Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Location *location = [_locations objectAtIndex:indexPath.row];
    
    cell.textLabel.text = location.title;
    cell.detailTextLabel.text = location.place;
    //cell.imageView.image = [UIImage imageNamed:@"map.png"];
    
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_locations count];
}

@end
