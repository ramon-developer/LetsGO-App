//
//  Location.m
//  LetsGOApp
//
//  Created by Marbet  Ramon on 5/19/17.
//  Copyright © 2017 Ramon. All rights reserved.
//

#import "Location.h"

@implementation Location


- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init]) {
        _title = [jsonDictionary objectForKey:@"title"];
        _place = [jsonDictionary objectForKey:@"place"];
        _type = [jsonDictionary objectForKey:@"type"];
        _latitude = [jsonDictionary objectForKey:@"latitude"];
        _longitude = [jsonDictionary objectForKey:@"longitude"];
        _url = [jsonDictionary objectForKey:@"url"];
    }
    
    return self;
}

@end
