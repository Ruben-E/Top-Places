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
#import "FlickrFetcher.h"

@implementation TopPlacesFlickr

- (TopPlacesFlickr *)initWithFlickrData {
    self = [super init];
    
    if (!self) {
        NSURL *url = [FlickrFetcher URLforTopPlaces];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        self.countries = [self convertFlickrResponse:content];
    }
    
    return self;
}

-(void)addCountry:(Country *)country {
    [self.countries addObject:country];
}

- (Country *)getCountryByName:(NSString *)name {
    for (Country *country in self.countries) {
        if ([country.name isEqualToString:name]) {
            return country;
        }
    }
    
    return nil;
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

- (NSMutableArray *)convertFlickrResponse:(NSDictionary *)response {
    NSMutableArray *countries = [[NSMutableArray alloc] init];
    
    NSDictionary *placesResults = response[@"places"];
    NSArray *places = placesResults[@"place"];
    
    for (NSDictionary *flickrPlace in places) {
        NSString *placeName = flickrPlace[@"_content"];
        NSArray *placeNameParts = [placeName componentsSeparatedByString:@", "];
        
        NSString *countryName = [placeNameParts lastObject];
        
        Country *country = [self getCountryByName:countryName];
        if (!country) {
            country = [[Country alloc] init];
            [self addCountry:country];
        }
        
        Place *place = [[Place alloc] init];
        place.name = flickrPlace[@"woe_name"];
        
        [country.places addObject:place];
    }
    
    return countries;
}

#pragma mark Setters / Getters

- (NSMutableArray *)countries {
    if (!_countries) {
        _countries = [[NSMutableArray alloc] init];
    }
    
    return _countries;
}

@end
