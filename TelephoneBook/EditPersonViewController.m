//
//  EditPersonViewController.m
//  TelephoneBook
//
//  Created by Developer on 29/09/14.
//  Copyright (c) 2014 TundraMobile. All rights reserved.
//

#import "EditPersonViewController.h"
#import "ContactsViewController.h"
#import "PersonViewController.h"
#import "Core.h"
#import "Person.h"
#import <QuartzCore/QuartzCore.h>

@interface EditPersonViewController () <UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *lastNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberLabel;
- (IBAction)deleteContact:(id)sender;
- (IBAction)addPhoto:(id)sender;

@end

@implementation EditPersonViewController
@synthesize selectedImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done"
                                   style:UIBarButtonItemStylePlain
                                   target: self
                                   action:@selector(doneButton)];
    [self.navigationItem setRightBarButtonItem: doneButton];
    self.title = @"Info";
    
    _firstNameLabel.text = _person.firstName;
    _lastNameLabel.text = _person.lastName;
    _phoneNumberLabel.text = _person.phoneNumber;
    [_addPhotoButton setImage:_person.image forState:UIControlStateNormal];
    
    _firstNameLabel.delegate = self;
    _lastNameLabel.delegate = self;
    _phoneNumberLabel.delegate = self;
    
    [[_addPhotoButton layer] setBorderWidth:1.0f];
    [[_addPhotoButton layer] setBorderColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) doneButton
{
    _person.firstName = _firstNameLabel.text;
    _person.lastName = _lastNameLabel.text;
    _person.fullName = [NSString stringWithFormat:@"%@ %@", _person.firstName, _person.lastName];
    _person.phoneNumber = _phoneNumberLabel.text;
    _person.image = _addPhotoButton.currentImage;
    [self.navigationController popToRootViewControllerAnimated:true];
}



- (IBAction)deleteContact:(id)sender
{
    [[Core getInstance].persons removeObject:_person];
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (IBAction)addPhoto:(id)sender
{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;        
    }
    else
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentModalViewController:picker animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *) Picker
{
    [self.navigationController dismissViewControllerAnimated: YES completion: nil];
}

- (void)imagePickerController:(UIImagePickerController *) Picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *btnImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_addPhotoButton setImage:btnImage forState:UIControlStateNormal];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
