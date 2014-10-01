
#import "ContactsViewController.h"
#import "ContactsViewController.m"
#import "Person.h"
#import "AddContactViewController.h"
#import "PersonViewController.h"
#import "Core.h"

static NSString *kCellId = @"CellId";

@interface ContactsViewController()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ContactsViewController
@synthesize mySearchBar, filteredPersons, isFiltered;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"+"
                                  style:UIBarButtonItemStylePlain
                                  target: self
                                  action:@selector(addItem)];
    [self.navigationItem setRightBarButtonItem: addButton];
    
    self.title = @"Contacts";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!isFiltered)
    {
        NSString *litter = [Core getInstance].titles[indexPath.section];
        NSMutableArray *persons = [NSMutableArray array];
    
        for (Person *person in [Core getInstance].persons)
        {
            if ([[person.fullName substringWithRange:NSMakeRange(0, 1)] isEqualToString:litter])
            [persons addObject:person];
        }
    
        Person *currentPerson = persons[indexPath.row];
        PersonViewController *vc2 = [[PersonViewController alloc] init];
        vc2.person = currentPerson;
        [[self navigationController]pushViewController:vc2 animated:YES];
    }
    else
    {
        Person *currentPerson = filteredPersons[indexPath.row];
        PersonViewController *vc2 = [[PersonViewController alloc] init];
        vc2.person = currentPerson;
        [[self navigationController]pushViewController:vc2 animated:YES];
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if(isFiltered == NO)
    {
        return [Core getInstance].titles;
    }
    else
    {
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(isFiltered == NO)
    {
        NSMutableArray *sections = [NSMutableArray array];
        for (Person *person in [Core getInstance].persons)
        {
            NSString *title = [person.fullName substringWithRange:NSMakeRange(0, 1)];
            
            if (![sections containsObject:title])
            {
                [sections addObject:title];
            }
        }
        [sections sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [Core getInstance].titles = sections;
        return [Core getInstance].titles.count;
    }
    else
    {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!isFiltered)
        return [Core getInstance].titles[section];
    else
        return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isFiltered == YES)
    {
        return filteredPersons.count;
    }
    else
    {
        NSString *sectionTitle = [[Core getInstance].titles objectAtIndex:section];
        NSMutableArray *contactsForTitle = [NSMutableArray array];
    
        for (Person *person in [Core getInstance].persons)
        {
            if ([[person.fullName substringWithRange:NSMakeRange(0, 1)] isEqualToString:sectionTitle])
            {
                [contactsForTitle addObject:person];
            }
        }
        return contactsForTitle.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];

    NSString *litter = [Core getInstance].titles[indexPath.section];
    NSMutableArray *persons = [NSMutableArray array];
    
    if (!isFiltered)
    {
        for (Person *person in [Core getInstance].persons)
        {
            if ([[person.fullName substringWithRange:NSMakeRange(0, 1)] isEqualToString:litter])
            {
                [persons addObject:person];
            }
        }
    }

    if(isFiltered)
    {
        Person *currentFilteredPerson = filteredPersons[indexPath.row];
        cell.textLabel.text = currentFilteredPerson.fullName;
    }
    else
    {
        Person *currentPerson = persons[indexPath.row];
        cell.textLabel.text = currentPerson.fullName;
    }
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        isFiltered = NO;
    }
    else
    {
        isFiltered = YES;
        filteredPersons = [[NSMutableArray alloc] init];
        
        for(Person* person in [Core getInstance].persons)
        {
            NSRange personNameRange = [person.fullName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(personNameRange.location != NSNotFound)
            {
                [filteredPersons addObject:person];
            }
        }       
    }
    [self.tableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.tableView reloadData];
    isFiltered = NO;
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton = NO;
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    searchBar.text= nil;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [mySearchBar resignFirstResponder];
    mySearchBar.showsCancelButton = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void) addItem
{
    AddContactViewController *addContact = [[AddContactViewController alloc] init];
    [[self navigationController]pushViewController:addContact animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (isFiltered)
    {
        [self searchBar:self.mySearchBar textDidChange:self.mySearchBar.text];
    }
    [self.tableView reloadData];
}

@end

