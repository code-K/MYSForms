//
//  MYSFormElement.h
//  MYSForms
//
//  Created by Adam Kirk on 5/3/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "MYSFormPresenceValidation.h"
#import "MYSFormRegexValidation.h"


@class MYSFormElement;
@class MYSFormCell;
@class MYSFormTheme;


@protocol MYSFormElementDataSource;
@protocol MYSFormElementDelegate;


/**
 Do not create direct instances of this class. It is meant to be subclassed.
 */
@interface MYSFormElement : NSObject

/**
 When creating custom form elements, you this will be set up for you and you can use the delegate methods to instruct
 the form view controller to do a variety of things for you.
 */
@property (nonatomic, weak) id<MYSFormElementDelegate> delegate;

/**
 When creating custom form elements, you can use this to get information about the form's model.
 */
@property (nonatomic, weak) id<MYSFormElementDataSource> dataSource;

/**
 The key path to the property on the forms model that this element should be bound to.
 */
@property (nonatomic, copy) NSString *modelKeyPath;

/**
 The cell ued to display this form element. This is `nil` until the collection view that displays the form creates it.
 */
@property (nonatomic, strong) MYSFormCell *cell;

/**
 Controls whether any actionable UIViews are enabled in this form element.
 */
@property (nonatomic, getter = isEnabled) BOOL enabled;

/**
 The class of the cell to be used to display this form element. By default, this is the same name as this class with Cell replacing Element.
 */
@property (nonatomic) Class cellClass;

/**
 The theme that will be applied to the appropriate views in the view representation of this element (the cell).
 */
@property (nonatomic, strong) MYSFormTheme *theme;

/**
 Is asked of the element to make sure this element can be added for this form/device/orientation/whatever.
 For example, the image picker element can't be added on a device with no cameras and no library.
 */
- (BOOL)canAddElement;

/**
 This calls the delegate (the form) to get the current model value for this element's key path.
 */
- (id)currentModelValue;

/**
 If any data on this element has changed, call this method to update the cell so it's displayed to the user.
 */
- (void)updateCell;

/**
 Called after the cell of this element has been created and assinged to the element, giving you a chance to fully customize
 the look of the cell that will visually represent this element.
 */
- (void)configureCellBlock:(void (^)(id))block;

/**
 Returns YES if this is the type of form element that accepts text input.
 */
- (BOOL)isTextInput;

/**
 Returns YES if the element has a value that can be edited.
 */
- (BOOL)isEditable;

/**
 Make a text input first responder, or "tap" selection style input, or just dismiss the keyboard for inputs such as toggles.
 */
- (void)beginEditing;

/**
 Returns YES if the `modelKeyPath` is valid for use setting and getting values on the model. An attempt to do so with an invalid
 `modelKeyPath` will result in an exception, so always use this to check first.
 */
- (BOOL)isModelKeyPathValid;

/**
 Add a validation for this element so that when `validationErrors` is called, the validation will be run against the value of
 the form element and generate an error if a validation fails.
 */
- (void)addFormValidation:(MYSFormValidation *)formValidation;

/**
 Will return either an empty array or an arry of NSError objects that contain `localizedDescription`s of the failure reason.
 */
- (NSArray *)validationErrors;

/**
 Add a value transformer that takes the value at `modelKeyPath` and transforms it to what the element cell expects. You can also
 provide a reverse transform that will transform the cell value back to type of value the model expects.
 */
@property (nonatomic, retain) NSValueTransformer *valueTransformer;

@end


@protocol MYSFormElementDataSource <NSObject>
- (id)modelValueForFormElement:(MYSFormElement *)formElement;
@end


@protocol MYSFormElementDelegate <NSObject>

- (void)formElement:(MYSFormElement *)formElement valueDidChange:(id)value;

- (void)formElementNeedsLayout:(MYSFormElement *)formElement;

- (void)formElement:(MYSFormElement *)formElement didRequestPresentationOfActionSheet:(UIActionSheet *)actionSheet;

- (void)formElement:(MYSFormElement *)formElement didRequestPresentationOfViewController:(UIViewController *)viewController
           animated:(BOOL)animated
         completion:(void (^)(void))completion;

- (void)formElement:(MYSFormElement *)formElement didRequestPresentationOfChildView:(UIView *)childView;

- (void)formElement:(MYSFormElement *)formElement didRequestDismissalOfChildView:(UIView *)childView;

- (void)formElementDidRequestResignationOfFirstResponder:(MYSFormElement *)formElement;

@end


