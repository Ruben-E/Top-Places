//
//  Country.h
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"

@interface Country : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *places;

- (Place *)getPlaceByRowNumber:(NSUInteger)rowNumber;
- (void)sortPlaces;

@end
