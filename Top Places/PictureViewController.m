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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

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
    
    [self startDownloadingImage];
}

- (void)startDownloadingImage {
    self.image = nil;
    
    if (self.picture) {
        [self.activityIndicator startAnimating];
        
        NSURL *url = [FlickrFetcher URLforPhoto:self.picture.raw format:FlickrPhotoFormatLarge];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
            if (!error) {
                if ([request.URL isEqual:url]) {
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.image = image;
                    });
                }
            }
        }];
        
        [task resume];
    }
}

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    
    [self.imageView sizeToFit];
    
    if (image) {
        self.scrollView.contentSize = image ? self.image.size : CGSizeZero;
        
        int scrollViewWidth = self.scrollView.bounds.size.width;
        int imageViewWidth = self.image.size.width;
        float zoomScale = (float) scrollViewWidth / (float) imageViewWidth;
        
        self.scrollView.zoomScale = zoomScale;
        self.scrollView.minimumZoomScale = zoomScale;
        
        [self.activityIndicator stopAnimating];
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    
    return _imageView;
}

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    
    _scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    
    _scrollView.minimumZoomScale = 0.1;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.clipsToBounds = YES;
    
    _scrollView.delegate = self;
    _scrollView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                   UIViewAutoresizingFlexibleHeight);
}
@end
