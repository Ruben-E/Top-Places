//
//  Picture.h
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Picture : NSObject

#define FLICKR_PHOTO_TITLE @"title"
#define FLICKR_PHOTO_DESCRIPTION @"description._content"
#define FLICKR_PHOTO_ID @"id"
#define FLICKR_PHOTO_OWNER @"ownername"
#define FLICKR_PHOTO_UPLOAD_DATE @"dateupload" // in seconds since 1970
#define FLICKR_PHOTO_PLACE_ID @"place_id"

@property (nonatomic) NSUInteger pictureId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic) NSUInteger owner;
@property (nonatomic) NSUInteger uploaded_at;
@property (nonatomic, strong, readonly) NSURL *url;
@property (nonatomic, strong) NSDictionary *raw;

@end
