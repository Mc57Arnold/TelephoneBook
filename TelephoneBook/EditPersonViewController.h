//
//  EditPersonViewController.h
//  TelephoneBook
//
//  Created by Developer on 29/09/14.
//  Copyright (c) 2014 TundraMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Person;
@interface EditPersonViewController : UIViewController
{
    UIImagePickerController *picker;
}
@property (nonatomic, strong) Person *person;
@property (nonatomic, retain) UIImageView * selectedImage;
@end
