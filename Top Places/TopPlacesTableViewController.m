//
//  TopPlacesTableViewController.m
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import "TopPlacesTableViewController.h"
#import "TopPlacesFlickr.h"
#import "Place.h"
#import "PlaceTableViewController.h"

@interface TopPlacesTableViewController ()

@end

@implementation TopPlacesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startDownloadingData];
}

- (IBAction)startDownloadingData {
    [self.refreshControl beginRefreshing];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        [self.topPlacesFlickr parseFlickrData];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        });
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.topPlacesFlickr.countries count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Country *country = [self.topPlacesFlickr getCountryByRowNumber:section];
    return country.name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Country *country = [self.topPlacesFlickr getCountryByRowNumber:section];
    return [country.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Country *country = [self.topPlacesFlickr getCountryByRowNumber:indexPath.section];
    Place *place = [country getPlaceByRowNumber:indexPath.row];
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = place.name;
    cell.detailTextLabel.text = place.state;
    
    // Configure the cell...
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowTopPicturesOfCity"]) {
        PlaceTableViewController *placeTableViewController = (PlaceTableViewController *)[segue destinationViewController];
        
        UITableViewCell *cell = (UITableViewCell*)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        Country *country = [self.topPlacesFlickr getCountryByRowNumber:indexPath.section];
        Place *place = [country getPlaceByRowNumber:indexPath.row];
        
        if (place) {
            placeTableViewController.place = place;
        }
    }
}


#pragma mark Setters / Getters

- (TopPlacesFlickr *)topPlacesFlickr {
    if (!_topPlacesFlickr) {
        _topPlacesFlickr = [[TopPlacesFlickr alloc] init];
    }
    
    return _topPlacesFlickr;
}

@end
