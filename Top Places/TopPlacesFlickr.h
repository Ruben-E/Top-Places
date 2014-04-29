//
//  TopPlaces.h
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopPlacesFlickr : NSObject

@property NSArray *countries;


- (TopPlacesFlickr *)initWithFlickrData;
- (void)getPictures;
- (void)getPlaces;
- (void)getPictureByRowNumber:(NSUInteger) rowNumber;
- (void)getPictureByPictureId:(NSUInteger) pictureId;


@end
