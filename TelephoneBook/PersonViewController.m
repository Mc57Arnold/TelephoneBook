
#import "PersonViewController.h"
#import "ContactsViewController.h"
#import "EditPersonViewController.h"
#import <MessageUI/MessageUI.h>
#import "Core.h"

@interface PersonViewController ()


@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
- (IBAction)callButton:(id)sender;
- (IBAction)sendSMSButton:(id)sender;
@end

@implementation PersonViewController

- (id)initWithPerson:(Person *)person
{
    self = [super initWithNibName:@"PersonViewController" bundle:nil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Edit"
                                  style:UIBarButtonItemStylePlain
                                  target: self
                                  action:@selector(editButton)];
    [self.navigationItem setRightBarButtonItem: editButton];
    self.title = @"Info";
    
    _fullNameLabel.text = _person.fullName;
    _photo.image = _person.image;
    _phoneNumberLabel.text = _person.phoneNumber;
}



 
- (void) editButton
{
    EditPersonViewController *editPerson = [[EditPersonViewController alloc] init];
    editPerson.person = self.person;
    [[self navigationController]pushViewController:editPerson animated:YES];
}


- (IBAction)callButton:(id)sender
{
    NSString *phNo = _person.phoneNumber;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
    {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [calert show];
    }
    
}

- (IBAction)sendSMSButton:(id)sender
{
    NSString *phNo =_person.phoneNumber;
    [self sendSMS:@"Body of SMS..." recipientList:phNo];
}

- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled)
    {
        NSLog(@"Message cancelled");
    }
    else if (result == MessageComposeResultSent)
    {
        NSLog(@"Message sent");
    }
    else
    {
        NSLog(@"Message failed");
    }
}

@end
