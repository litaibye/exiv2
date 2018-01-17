//
//  test.h
//  exivtest
//
//  Created by Kanstantsin Bucha on 1/17/18.
//  Copyright © 2018 Truebucha. All rights reserved.
//

#import <Foundation/Foundation.h>


// The source of exiv2 dynamic library downloaded from http://www.exiv2.org/

@interface TestExiv : NSObject

- (void) readFrom: (NSString *) file;
- (NSString *) readJSONStringFrom: (NSString *) file;

@end
