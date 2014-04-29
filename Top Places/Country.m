//
//  Country.m
//  Top Places
//
//  Created by Ruben Ernst on 29-04-14.
//  Copyright (c) 2014 Ruben Ernst. All rights reserved.
//

#import "Country.h"

@implementation Country

- (Place *)getPlaceByRowNumber:(NSUInteger)rowNumber {
    return [self.places objectAtIndex:rowNumber];
}

- (NSMutableArray *)places {
    if (!_places) {
        _places = [[NSMutableArray alloc] init];
    }
    
    return _places;
}

@end
