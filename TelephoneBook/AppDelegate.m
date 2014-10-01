//
//  AppDelegate.m
//  TelephoneBook
//
//  Created by Developer on 15/09/14.
//  Copyright (c) 2014 TundraMobile. All rights reserved.
//

#import "AppDelegate.h"
#import "ContactsViewController.h"
#import "Core.h"
#import "Person.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UINavigationController *navVC = [[UINavigationController alloc] init];
    ContactsViewController *vcContacts = [[ContactsViewController alloc] init];
    
    [navVC setViewControllers:[NSArray arrayWithObject:vcContacts]];
    
    [self.window setRootViewController:navVC];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = [Core getInstance].persons ;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    [defaults setObject:data forKey:@"Key"];
}

@end


