//
//  MYSSignUpFormViewController.m
//  MYSForms
//
//  Created by Adam Kirk on 5/3/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "MYSSignUpFormViewController.h"
#import "MYSFakeUser.h"


@interface MYSSignUpFormViewController ()
@end


@implementation MYSSignUpFormViewController

- (void)configureForm
{
    [super configureForm];

    MYSFormHeadlineElement *title = [MYSFormHeadlineElement headlineFormElementWithHeadline:@"Sign Up"];
    [self addFormElement:title];

    MYSFormFootnoteElement *description = [MYSFormFootnoteElement new];
    description.footnote = @"A table view displays a list of items in a single column. UITableView is a subclass of UIScrollView.";
    [self addFormElement:description];

    MYSFormTextFieldElement *firstNameField = [MYSFormTextFieldElement textFieldFormElementWithLabel:@"First Name" modelKeyPath:@"firstName"];
    [self addFormElement:firstNameField];

    MYSFormTextFieldElement *lastNameField = [MYSFormTextFieldElement textFieldFormElementWithLabel:@"Last Name" modelKeyPath:@"lastName"];
    [self addFormElement:lastNameField];

    MYSFormTextFieldElement *emailField = [MYSFormTextFieldElement textFieldFormElementWithLabel:@"E-mail" modelKeyPath:@"email"];
    emailField.keyboardType = UIKeyboardTypeEmailAddress;
    [self addFormElement:emailField];

    MYSFormTextFieldElement *passwordField = [MYSFormTextFieldElement textFieldFormElementWithLabel:@"Password" modelKeyPath:@"password"];
    passwordField.secure = YES;
    [self addFormElement:passwordField];

    MYSFormButtonElement *signUpButton = [MYSFormButtonElement buttonFormElementWithTitle:@"Sign Up"
                                                                                   target:self
                                                                                   action:@selector(signUpButtonWasTapped:)];
    [self addFormElement:signUpButton];
}




#pragma mark - Actions

- (void)signUpButtonWasTapped:(id)sender
{
    NSLog(@"sign up button was tapped");
}


@end
