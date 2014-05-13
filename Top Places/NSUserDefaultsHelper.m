//
//  NSUserDefaultsHelper.m
//  Top Places
//
//  Created by Ruben Ernst on 09-05-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import "NSUserDefaultsHelper.h"

@implementation NSUserDefaultsHelper

+ (void)savePictureWithURL:(NSString *)URL andTitle:(NSString *)title; {
    NSMutableArray *pictures = [[NSMutableArray alloc] initWithArray:[NSUserDefaultsHelper getPictures]];
    
    NSMutableDictionary *picture = [[NSMutableDictionary alloc] init];
    [picture setObject:URL forKey:@"URL"];
    [picture setObject:title forKey:@"title"];
    
    for (NSDictionary *pictureFromList in pictures) {
        if ([(NSString *)[pictureFromList objectForKey:@"URL"] isEqualToString:URL] && [(NSString *)[pictureFromList objectForKey:@"title"] isEqualToString:title]) {
            [pictures removeObject:pictureFromList];
            break;
        }
    }
    
    [pictures insertObject:picture atIndex:0];
    
    if ([pictures count] > 50) {
        [pictures removeLastObject];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:pictures forKey:NSUSERDEFAULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)getPictures {
    return [[NSUserDefaults standardUserDefaults] objectForKey:NSUSERDEFAULTS_KEY];
}

@end
