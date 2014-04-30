//
//  PhotoViewController.m
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import "PictureViewController.h"
#import "FlickrFetcher.h"

@interface PictureViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation PictureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.picture.title;
    
    [self.scrollView addSubview:self.imageView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
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
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    
    return _imageView;
}

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
    
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}
@end
