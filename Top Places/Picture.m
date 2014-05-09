//
//  Picture.m
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import "Picture.h"
#import "FlickrFetcher.h"

@implementation Picture

- (NSURL *)url {
    NSURL *url = [FlickrFetcher URLforPhoto:self.raw format:FlickrPhotoFormatLarge];
    return url;
}

@end
