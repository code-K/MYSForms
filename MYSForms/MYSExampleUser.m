//
//  MYSFakeUser.m
//  MYSForms
//
//  Created by Adam Kirk on 5/2/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "MYSExampleUser.h"

@implementation MYSExampleUser

- (NSString *)description
{
    return [NSString stringWithFormat:(@"\nFirst Name: %@ "
                                       @"\nLast Name: %@ "
                                       @"\nE-mail: %@ "
                                       @"\nPassword: %@"
                                       @"\nAge: %@"
                                       @"\nDate of Birth: %@"
                                       @"\nAdult: %@"
                                       @"\nBio: %@"
                                       @"\nTags: %@"),
            self.firstName,
            self.lastName,
            self.email,
            self.password,
            @(self.yearsOld),
            self.birthDate,
            @(self.isLegalAdult),
            self.biography,
            self.tags];
}

@end
