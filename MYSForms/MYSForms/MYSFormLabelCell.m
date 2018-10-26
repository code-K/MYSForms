//
//  MYSFormHeadlineElement.m
//  MYSForms
//
//  Created by Adam Kirk on 5/2/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "MYSFormLabelCell.h"
#import "MYSFormLabelElement.h"
#import "MYSFormTheme.h"


@implementation MYSFormLabelCell

+ (CGSize)sizeRequiredForElement:(MYSFormLabelElement *)element width:(CGFloat)width
{
    UIEdgeInsets insets = [element.theme.contentInsets UIEdgeInsetsValue];
    width -= insets.left + insets.right;
    
    if (element.attrLabel == nil){
        CGSize size = [element.label boundingRectWithSize:CGSizeMake(width, FLT_MAX)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{
                                                            NSFontAttributeName : element.theme.labelFont
                                                            }
                                                  context:nil].size;
        
        size.height = ceil(size.height) + insets.top + insets.bottom;
        return size;
    }else{
        CGSize attrSize = [element.attrLabel boundingRectWithSize:CGSizeMake(width, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        attrSize.height = ceil(attrSize.height) + insets.top + insets.bottom;
        return attrSize;
    }
    
}

- (void)populateWithElement:(MYSFormLabelElement *)element
{
    
    if (element.attrLabel == nil) {
        self.label.text = element.label;
    }else{
        self.label.attributedText = element.attrLabel;
    }
    
    [super populateWithElement:element];
}

- (void)applyTheme:(MYSFormTheme *)theme
{
    [super applyTheme:theme];
    self.label.font = theme.labelFont;
    self.label.textColor = theme.labelTextColor;
}

@end