//
//  AddContactViewController.m
//  TelephoneBook
//
//  Created by Developer on 19/09/14.
//  Copyright (c) 2014 TundraMobile. All rights reserved.
//

#import "AddContactViewController.h"
#import "ContactsViewController.h"
#import "Person.h"
#import "Core.h"
#import <QuartzCore/QuartzCore.h>

@interface AddContactViewController () <UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *firstNameField;
@property (retain, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *addPhotoButton;
- (IBAction)addPhoto:(id)sender;

@end

@implementation AddContactViewController

- (id)initWithPerson:(Person *)person
{
    self = [super initWithNibName:@"AddContactViewController" bundle:nil];
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
    
    self.title = @"New Contact";
    _firstNameField.delegate = self;
    _lastNameField.delegate = self;
    _phoneNumber.delegate = self;
    
    [[_addPhotoButton layer] setBorderWidth:1.0f];
    [[_addPhotoButton layer] setBorderColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor];
}



- (void) doneButton
{
    Person *person = [[Person alloc] init];
    person.firstName = _firstNameField.text;
    person.lastName = _lastNameField.text;
    
    if([person.firstName length] == 0  && [person.lastName length] == 0)
    {
        person.firstName = @"No name";
    }
    
    person.fullName = [NSString stringWithFormat:@"%@ %@", person.firstName, person.lastName];
    person.phoneNumber = _phoneNumber.text;
    person.image = _addPhotoButton.currentImage;
    
    [[Core getInstance].persons addObject:person];
    [self.navigationController popViewControllerAnimated:true];
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










