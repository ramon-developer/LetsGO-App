//
//  JSONLoader.h
//  LetsGOApp
//
//  Created by Marbet Ramon on 5/19/17.
//  Copyright © 2017 Ramon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONLoader : NSObject

//retorna o array do JSON
- (NSArray *)locationsFromJSONurl:(NSURL *)url;

@end
