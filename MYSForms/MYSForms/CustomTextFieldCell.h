//
//  CustomTextFieldCell.h
//  Choo
//
//  Created by CK-UDG on 01.02.15.
//  Copyright (c) 2015 Christian Koch, Choo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MYSForms.h>

@class ErstattungsCheckViewController;
@class ErstattungsinfoViewController;
@class ErstattungsinfoDepartureViewController;
@class ErstattungsinfoDidChangeViewController;

@interface CustomTextFieldCell : MYSFormTextFieldCell

@property (nonatomic, retain) ErstattungsCheckViewController *firstVC;
@property (nonatomic, retain) ErstattungsinfoViewController *secondVC;
@property (nonatomic, retain) ErstattungsinfoDepartureViewController *thirdVC;
@property (nonatomic, retain) ErstattungsinfoDidChangeViewController *fourthVC;

@end