//
//  TopPlaces.h
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
#import "Country.h"
#import "Place.h"

@interface TopPlacesFlickr : NSObject

@property (nonatomic, strong) NSMutableArray *countries;

- (TopPlacesFlickr *)initWithFlickrData;
- (BOOL)parseFlickrData;

- (NSArray *)getPictures;
- (NSArray *)getPlaces;

- (void)addCountry:(Country *)country;

- (Country *)getCountryByName:(NSString *)name;
- (Country *)getCountryByRowNumber:(NSUInteger) rowNumber;
- (Picture *)getPictureByPictureId:(NSUInteger) pictureId;


@end
