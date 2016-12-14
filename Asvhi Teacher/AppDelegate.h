//
//  AppDelegate.h
//  Asvhi Teacher
//
//  Created by Prem Kumar on 23/11/16.
//  Copyright © 2016 Prem Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    HomeViewController *homeObj;
    UINavigationController *naviObj;
}
@property (strong, nonatomic) UIWindow *window;


@end

