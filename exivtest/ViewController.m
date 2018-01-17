//
//  ViewController.m
//  exivtest
//
//  Created by Kanstantsin Bucha on 1/17/18.
//  Copyright © 2018 Truebucha. All rights reserved.
//

#import "ViewController.h"
#import "TestExiv.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL * url = [NSBundle.mainBundle URLForResource: @"769474"
                                        withExtension: @"JPG"];
    if (url == nil) {
        return;
    }
    
    NSString * imagePath = url.path;
    
    TestExiv * test = [TestExiv new];
    NSLog(@"JSON representation still have some glitches, maybe connected with string length somehow");
    NSString * json = [test readJSONStringFrom: imagePath];
    if (json != nil) {
        NSLog(@"%@", json);
    }
    NSLog(@"======================\n==\n==\n==\n==\n==\n==\n======================\n");
    [test readFrom: imagePath];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
