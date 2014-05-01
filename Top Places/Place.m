//
//  Place.m
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import "Place.h"
#import "FlickrFetcher.h"
#import "Picture.h"

@implementation Place

const unsigned int DEFAULT_MAX_RESULTS = 50;

- (NSMutableArray *)pictures {
    if (!_pictures) {
        _pictures = [[NSMutableArray alloc] init];
    }
    
    return _pictures;
}

- (void)parseFlickrDataWithMaxResults:(NSUInteger)maxResults {
    NSURL *url = [FlickrFetcher URLforPhotosInPlace:self.placeId maxResults:maxResults];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    self.pictures = [self convertFlickrResponse:content];
}

- (void)parseFlickrData {
    [self parseFlickrDataWithMaxResults:DEFAULT_MAX_RESULTS];
}

- (NSMutableArray *)convertFlickrResponse:(NSDictionary *)response {
    NSArray *flickrPictures = [response valueForKeyPath:FLICKR_RESULTS_PHOTOS];
    NSMutableArray *pictures = [[NSMutableArray alloc] init];
    
    for (NSDictionary *flickrPicture in flickrPictures) {
        Picture *picture = [[Picture alloc] init];
        picture.pictureId = [(NSString *)[flickrPicture valueForKeyPath:FLICKR_PHOTO_ID] integerValue];
        picture.title = [flickrPicture valueForKeyPath:FLICKR_PHOTO_TITLE];
        picture.description = [flickrPicture valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        picture.owner = [(NSString *)[flickrPicture valueForKeyPath:FLICKR_PHOTO_OWNER] integerValue];
        picture.uploaded_at = [(NSString *)[flickrPicture valueForKeyPath:FLICKR_PHOTO_UPLOAD_DATE] integerValue];
        picture.raw = flickrPicture;
        
        if ([picture.title isEqualToString:@""]) {
            picture.title = picture.description;
        }
        
        if ([picture.title isEqualToString:@""]) {
            picture.title = @"Unknown";
        }
        
        [pictures addObject:picture];
    }
    
    return pictures;
}

- (Picture *)getPictureByRowNumber:(NSUInteger)rowNumber {
    return [self.pictures objectAtIndex:rowNumber];
}

@end
