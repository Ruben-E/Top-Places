//
//  TopPlaces.h
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"

@interface TopPlacesFlickr : NSObject

@property (nonatomic, strong) NSArray *countries;

- (TopPlacesFlickr *)initWithFlickrData;
- (NSArray *)getPictures;
- (NSArray *)getPlaces;
- (Picture *)getPictureByRowNumber:(NSUInteger) rowNumber;
- (Picture *)getPictureByPictureId:(NSUInteger) pictureId;


@end
