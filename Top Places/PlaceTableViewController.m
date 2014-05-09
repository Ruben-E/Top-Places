//
//  CityTableViewController.m
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import "PlaceTableViewController.h"
#import "Place.h"
#import "PictureViewController.h"
#import "NSUserDefaultsHelper.h"

@interface PlaceTableViewController ()

@end

@implementation PlaceTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.place) {
        self.title = self.place.name;
    }
    
    [self startDownloadingData];
}

- (IBAction)startDownloadingData {
    [self.refreshControl beginRefreshing];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        [self.place parseFlickrData];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        });
    });
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id detail = self.splitViewController.viewControllers[1];
    if ([detail isKindOfClass:[UINavigationController class]]) {
        detail = [((UINavigationController *)detail).viewControllers firstObject];
    }
    
    if ([detail isKindOfClass:[PictureViewController class]]) {
        Picture *picture = [self.place getPictureByRowNumber:indexPath.row];
        PictureViewController *pictureViewController = (PictureViewController *)detail;
        
        [self prepateImagePictureViewController:pictureViewController toDisplayPicture:picture];
    }
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.place.pictures count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Picture *picture = [self.place getPictureByRowNumber:indexPath.row];
    
    if (picture) {
        cell.textLabel.text = picture.title;
        cell.detailTextLabel.text = picture.description;
    }
    
    return cell;
}



- (void)prepateImagePictureViewController:(PictureViewController *)pictureViewController toDisplayPicture:(Picture *)picture {
    pictureViewController.pictureURL = picture.url;
    pictureViewController.pictureTitle = picture.title;
    pictureViewController.title = picture.title;
    
    [NSUserDefaultsHelper savePictureWithURL:[picture.url absoluteString] andTitle:picture.title];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowPicture"]) {
        PictureViewController *pictureViewController = (PictureViewController *)[segue destinationViewController];
        
        UITableViewCell *cell = (UITableViewCell*)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        Picture *picture = [self.place getPictureByRowNumber:indexPath.row];
        
        if (picture) {
            [self prepateImagePictureViewController:pictureViewController toDisplayPicture:picture];
        }
    }
}

@end
