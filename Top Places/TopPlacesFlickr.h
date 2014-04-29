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

@interface TopPlacesFlickr : NSObject

@property (nonatomic, strong) NSMutableArray *countries;

- (void)addCountry:(Country *)country;
- (TopPlacesFlickr *)initWithFlickrData;
- (NSArray *)getPictures;
- (NSArray *)getPlaces;
- (Country *)getCountryByName:(NSString *)name;
- (Picture *)getPictureByRowNumber:(NSUInteger) rowNumber;
- (Picture *)getPictureByPictureId:(NSUInteger) pictureId;


@end
