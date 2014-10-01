//
//  PersonViewController.h
//  TelephoneBook
//
//  Created by Developer on 16/09/14.
//  Copyright (c) 2014 TundraMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <QuartzCore/QuartzCore.h>
#import "Person.h"

@interface PersonViewController : UIViewController

@property (nonatomic, strong) Person *person;
- (id)initWithPerson:(Person*)person;

@end
