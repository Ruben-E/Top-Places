//
//  NSUserDefaultsHelper.h
//  Top Places
//
//  Created by Ruben Ernst on 09-05-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"

@interface NSUserDefaultsHelper : NSObject

#define NSUSERDEFAULTS_KEY @"recentPictures"

+ (void)savePictureWithURL:(NSString *)URL andTitle:(NSString *)title;
+ (NSArray *)getPictures;

@end
