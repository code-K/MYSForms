//
//  MYSFormButton.m
//  MYSForms
//
//  Created by Adam Kirk on 1/10/15.
//  Copyright (c) 2015 Mysterious Trousers. All rights reserved.
//

#import "MYSFormButton.h"

@implementation MYSFormButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.buttonStyle = MYSFormButtonStyleNone;
    }
    return self;
}

+ (instancetype)formButtonWithTitle:(NSString *)title action:(MYSFormButtonActionBlock)action
{
    MYSFormButton *button = [self new];
    button.action = action;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

- (void)setButtonStyle:(MYSFormButtonStyle)buttonStyle
{
    _buttonStyle = buttonStyle;
    if (self.buttonStyle == MYSFormButtonStyleDefault) {
        self.layer.cornerRadius = 0;
        self.layer.borderWidth = 0;
        self.layer.borderColor = nil;
        self.backgroundColor = nil;
    }
    else if (self.buttonStyle == MYSFormButtonStyleBordered) {
        self.layer.cornerRadius = 5.0;
        self.layer.borderWidth = 1.0;
        self.backgroundColor = nil;
    }
    else if (self.buttonStyle == MYSFormButtonStyleFilled) {
        self.layer.cornerRadius = 5.0;
        self.layer.borderWidth = 1.0;
    }
    [self setNeedsLayout];
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    UIColor *tint = [self superview].tintColor;
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(imageLayer.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [tint CGColor]);
    CGContextFillRect(context, imageLayer.frame);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = 5.0;
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (self.buttonStyle == MYSFormButtonStyleDefault) {
        [self setTitleColor:tint forState:UIControlStateNormal];
    }
    else if (self.buttonStyle == MYSFormButtonStyleBordered) {
        [self setTitleColor:tint forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self setBackgroundImage:roundedImage forState:UIControlStateHighlighted];
        [self setBackgroundImage:roundedImage forState:UIControlStateSelected];
        self.layer.borderColor = tint.CGColor;
    }
    else if (self.buttonStyle == MYSFormButtonStyleFilled) {
        self.layer.borderColor = tint.CGColor;
        self.backgroundColor = tint;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

@end


