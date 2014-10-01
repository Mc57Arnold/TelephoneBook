//
//  Person.h
//  TelephoneBook
//
//  Created by Developer on 16/09/14.
//  Copyright (c) 2014 TundraMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* fullName;
@property (nonatomic, strong) NSString* phoneNumber;
@property (nonatomic, strong) UIImage* image;

@end
