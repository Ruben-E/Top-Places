//
//  TopPlacesTableViewController.h
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopPlacesFlickr.h"

@interface TopPlacesTableViewController : UITableViewController

@property (nonatomic, strong) TopPlacesFlickr *topPlacesFlickr;

@end
