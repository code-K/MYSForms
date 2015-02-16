//
//  CustomTextFieldElement.h
//  Choo
//
//  Created by CK-UDG on 04.02.15.
//  Copyright (c) 2015 Christian Koch, Choo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomTextFieldCell.h"

@class ErstattungsCheckViewController;
@class ErstattungsinfoViewController;
@class ErstattungsinfoDepartureViewController;
@class ErstattungsinfoDidChangeViewController;
@class MYSFormElement;

@interface CustomTextFieldElement : MYSFormElement

@property (nonatomic, copy) NSString *label;

@property (nonatomic, assign, getter=isSecure) BOOL secure;

@property (nonatomic, assign) UIKeyboardType keyboardType;

@property (nonatomic, retain) ErstattungsCheckViewController *firstVC;
@property (nonatomic, retain) ErstattungsinfoViewController *secondVC;
@property (nonatomic, retain) ErstattungsinfoDepartureViewController *thirdVC;
@property (nonatomic, retain) ErstattungsinfoDidChangeViewController *fourthVC;

+ (instancetype)textFieldElementWithLabel:(NSString *)label modelKeyPath:(NSString *)modelKeyPath;

@end
