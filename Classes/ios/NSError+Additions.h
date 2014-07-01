//
//  NSError+Additions.h
//  DistanceMatrixWrapper
//
//  Created by Antonio Pinho on 05/05/14.
//  Copyright (c) 2014 evolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Additions)

+ (NSError *)errorWithCustomDescription:(NSString *)description;
- (NSString *)customDescription;

@end
