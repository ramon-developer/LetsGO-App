//
//  Location.h
//  LetsGOApp
//
//  Created by Marbet  Ramon on 5/19/17.
//  Copyright © 2017 Ramon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@property (readonly) NSString *title;
@property (readonly) NSString *place;
@property (readonly) NSNumber *latitude;
@property (readonly) NSNumber *longitude;
@property (readonly) NSString *type;
@property (readonly) NSString *url;

@end
