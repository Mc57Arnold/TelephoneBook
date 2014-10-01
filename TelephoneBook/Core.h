//
//  Core.h
//  TelephoneBook
//
//  Created by Developer on 22/09/14.
//  Copyright (c) 2014 TundraMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Core : NSObject
@property(nonatomic,retain)NSMutableArray *persons;
@property(nonatomic,retain)NSMutableArray *titles;
+ (Core *)getInstance;
//- (void)save;
//- (void)load;
@end
