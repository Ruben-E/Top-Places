//
//  Place.h
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"

@interface Place : NSObject

@property (nonatomic, strong) NSString *placeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSMutableArray *pictures;

extern unsigned int const DEFAULT_MAX_RESULTS;

- (void)parseFlickrDataWithMaxResults:(NSUInteger)maxResults;
- (void)parseFlickrData;
- (Picture *)getPictureByRowNumber:(NSUInteger)rowNumber;

@end
