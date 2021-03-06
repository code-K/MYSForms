//
//  MYSFormHeadlineElement.m
//  MYSForms
//
//  Created by Adam Kirk on 5/3/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "MYSFormLabelElement.h"


@implementation MYSFormLabelElement

+ (instancetype)labelElementWithText:(NSString *)text
{
    MYSFormLabelElement *element = [self new];
    element.label = text;
    element.attrLabel = nil;
    return element;
}

+ (instancetype)labelElementWithAttributedText:(NSMutableAttributedString *)attrText
{
    MYSFormLabelElement *element = [self new];
    element.attrLabel = attrText;
    element.label = nil;
    return element;
}

@end
