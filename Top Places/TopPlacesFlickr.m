//
//  TopPlaces.m
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import "TopPlacesFlickr.h"
#import "Place.h"
#import "Country.h"
#import "Picture.h"

@implementation TopPlacesFlickr

- (TopPlacesFlickr *)initWithFlickrData {
    if ([self init]) {
        //TODO: Fetch flickr data
    }
    
    return self;
}

- (NSArray *)getPlaces {
    NSMutableArray *places = [[NSMutableArray alloc] init];
    
    for (Country *country in self.countries) {
        for (Place *place in country.places) {
            [places addObject:place];
        }
    }
    
    return places;
}

- (NSArray *)getPictures {
    NSMutableArray *pictures = [[NSMutableArray alloc] init];
    
    for (Country *country in self.countries) {
        for (Place *place in country.places) {
            for (Picture *picture in place.pictures) {
                [pictures addObject:picture];
            }
        }
    }
    
    return pictures;
}

- (Picture *)getPictureByRowNumber:(NSUInteger)rowNumber {
    NSArray *pictures = [self getPictures];
    
    return [pictures objectAtIndex:rowNumber];
}

- (Picture *)getPictureByPictureId:(NSUInteger)pictureId {
    NSArray *pictures = [self getPictures];
    
    for (Picture *picture in pictures) {
        if (picture.pictureId == pictureId) {
            return picture;
        }
    }
    
    return nil;
}

#pragma mark Setters / Getters

- (NSArray *)countries {
    if (!self.countries) {
        self.countries = [[NSArray alloc] init];
    }
    
    return self.countries;
}

@end
