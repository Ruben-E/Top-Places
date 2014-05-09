//
//  RecentsTableViewController.m
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import "RecentsTableViewController.h"
#import "PictureViewController.h"
#import "NSUserDefaultsHelper.h"

@interface RecentsTableViewController ()

@property (nonatomic, strong) NSArray *recents;

@end

@implementation RecentsTableViewController

- (void)viewWillAppear:(BOOL)animated {
    if (self.recents) {
        self.recents = nil;
        [self.tableView reloadData];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id detail = self.splitViewController.viewControllers[1];
    if ([detail isKindOfClass:[UINavigationController class]]) {
        detail = [((UINavigationController *)detail).viewControllers firstObject];
    }
    
    if ([detail isKindOfClass:[PictureViewController class]]) {
        NSDictionary *picture = [self.recents objectAtIndex:indexPath.row];
        PictureViewController *pictureViewController = (PictureViewController *)detail;
        
        [self prepareImagePictureViewController:pictureViewController toDisplayPicture:picture];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *picture = [self.recents objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [picture objectForKey:@"title"];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareImagePictureViewController:(PictureViewController *)pictureViewController toDisplayPicture:(NSDictionary *)picture {
    pictureViewController.pictureTitle = [picture objectForKey:@"title"];
    pictureViewController.title = [picture objectForKey:@"title"];
    pictureViewController.pictureURL = [NSURL URLWithString:[picture objectForKey:@"URL"]];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowPicture"]) {
        PictureViewController *pictureViewController = (PictureViewController *)[segue destinationViewController];
        
        UITableViewCell *cell = (UITableViewCell*)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        NSDictionary *picture = [self.recents objectAtIndex:indexPath.row];
        
        if (picture) {
            [self prepareImagePictureViewController:pictureViewController toDisplayPicture:picture];
        }
    }
}

#pragma mark - Getters / Setters

- (NSArray *)recents {
    if (!_recents) {
        _recents = [NSUserDefaultsHelper getPictures];
    }
    
    return _recents;
}

@end
