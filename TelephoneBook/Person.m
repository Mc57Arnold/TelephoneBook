//
//  Person.m
//  TelephoneBook
//
//  Created by Developer on 16/09/14.
//  Copyright (c) 2014 TundraMobile. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)init
{
    self = [super init];
    if (self)
    {
        self.firstName = nil;
        self.lastName = nil;
        self.fullName = nil;
        self.phoneNumber = nil;
        self.image = nil;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.fullName forKey:@"fullName"];
    [encoder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
    [encoder encodeObject:self.image forKey:@"image"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self.firstName = [decoder decodeObjectForKey:@"firstName"];
    self.lastName = [decoder decodeObjectForKey:@"lastName"];
    self.fullName = [decoder decodeObjectForKey:@"fullName"];
    self.phoneNumber = [decoder decodeObjectForKey:@"phoneNumber"];
    self.image = [decoder decodeObjectForKey:@"image"];
    return self;
}

@end
