//
//  ContactsViewController.h
//  TelephoneBook
//
//  Created by Developer on 22/09/14.
//  Copyright (c) 2014 TundraMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar* mySearchBar;
@property (nonatomic, strong) NSMutableArray* filteredPersons;
@property BOOL isFiltered;

@end
