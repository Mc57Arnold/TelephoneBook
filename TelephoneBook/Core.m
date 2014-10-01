#import "Core.h"
#import "Person.h"

@implementation Core

static Core *instance = nil;

+ (Core *)getInstance
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Key"])
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *data = [defaults objectForKey:@"Key"];
            self.persons = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        else
        {
            self.persons = [self defaultPersons];
        }
        
        self.titles = [NSMutableArray array];
        
        for (Person *person in self.persons)
        {
            NSString *title = [person.firstName substringWithRange:NSMakeRange(0, 1)];
            if (![self.titles containsObject:title])
            {
                [self.titles addObject:title];
            }
            [self.titles sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

        }
    }

    return self;
}

- (NSMutableArray*)defaultPersons
{
    NSMutableArray *persons = [NSMutableArray array];
    NSArray *indeces = @[@"F", @"B", @"C", @"D", @"E", @"A", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
    int index = 0;
    for (NSString *litter in indeces)
    {
        Person *person = [[Person alloc] init];
        person.firstName = [NSString stringWithFormat:@"%@_Person", litter];
        person.lastName = @"Last Name";
        person.fullName = [NSString stringWithFormat:@"%@ %@", person.firstName, person.lastName];
        person.phoneNumber = [NSString stringWithFormat:@"%d", arc4random() % 1000000];
        index++;
        [persons addObject:person];
        
        if (index % 5 == 0)
        {
            Person *otherPerson = [[Person alloc] init];
            otherPerson.firstName = [NSString stringWithFormat:@"%@_Other_Person", litter];
            otherPerson.lastName = @"Last Name";
            otherPerson.fullName = [NSString stringWithFormat:@"%@ %@", otherPerson.firstName, otherPerson.lastName];
            otherPerson.phoneNumber = [NSString stringWithFormat:@"%d", arc4random() % 10000000];
            index++;
            [persons addObject:otherPerson];
        }
    }
    return persons;
}

@end



