//
//  PhotoViewController.m
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import "PictureViewController.h"
#import "FlickrFetcher.h"

@interface PictureViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

@end

@implementation PictureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
}

#pragma mark Setters / Getters

-(void)setPicture:(Picture *)picture {
    _picture = picture;
    
    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[FlickrFetcher URLforPhoto:self.picture.raw format:FlickrPhotoFormatLarge]]];
}

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    [self.imageView sizeToFit];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    
    return _imageView;
}
@end
