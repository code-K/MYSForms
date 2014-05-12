//
//  MYSFormViewController.h
//  MYSForms
//
//  Created by Adam Kirk on 5/1/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//


@class MYSFormElement;


@protocol MYSFormViewControllerDelegate;



/**
 This view controller can be used to manage a collection view, using it to display a form with a wealth of features. You simply
 create one of these form view controllers and configure it by adding form elements to it. You can also subclass it, making it
 compatible with storyboards. Drag a Collection View Controller onto your storyboard and assign your subclass to it. When it is 
 instantiated, your implementation of `configureForm` will be called where you can add form elements.
 */
@interface MYSFormViewController : UICollectionViewController

/**
 Set the model for this form. As you add form elements, you will associated those elements with key paths on the model and they will
 be linked bi-directionally. The form element will always display the current value of the model and the model will always be
 updated as the form element is updated by the user.
 */
@property (nonatomic, strong) id model;

/**
 The delegate for the form controller that lets you know of interesting events.
 */
@property (nonatomic, weak) id<MYSFormViewControllerDelegate> formDelegate;

/**
 If your method of choice is to subclass `MYSFormCollectionView`, override this method in your subclass to configure your form.
 */
- (void)configureForm;

/**
 If you create your own custom form elements, this is where you need to register their cell xibs with the collection view.
 You must call super as part of your implementation.
 */
- (void)registerElementCellsForReuse;

/**
 Create subclasses of `MYSFormElement` and use this method to add them to the form. Elements will be displayed in the order they were
 added with this method.
 */
- (void)addFormElement:(MYSFormElement *)element;

/**
 Allows you to add an element at a specific index;
 */
- (void)addFormElement:(MYSFormElement *)element atIndex:(NSInteger)index;

/**
 Runs all the validations on the model and adds validation errors by the elements that failed their validations.
 Returns YES if there were no errors and NO if there were validation errors.
 */
- (BOOL)validate;

/**
 A loading spinner with `message` will be displayed above the element specified. If nil is passed in for the element, the loading message
 will be displayed above the topmost element of the form.
 */
- (void)showLoadingMessage:(NSString *)message aboveElement:(MYSFormElement *)element completion:(void (^)(void))completion;

/**
 If an element is passed in, the loading messages above it will be dismissed. If nil is passed in, all loading messages will be dismissed.
 */
- (void)hideLoadingAboveElement:(MYSFormElement *)element completion:(void (^)(void))completion;

/**
 Displays an error message above `element` for the specified duration. `element` cannot be nil.
 */
- (void)showErrorMessage:(NSString *)message
            belowElement:(MYSFormElement *)element
                duration:(NSTimeInterval)duration
              completion:(void (^)(void))completion;

/**
 For manually hiding an error message if you didn't provide a duration when showing it, or you want to hide it early.
 */
- (void)hideErrorMessageBelowElement:(MYSFormElement *)element completion:(void (^)(void))completion;

/**
 Displays a success message below a form element.
 */
- (void)showSuccessMessage:(NSString *)message
              belowElement:(MYSFormElement *)element
                  duration:(NSTimeInterval)duration
                completion:(void (^)(void))completion;

/**
 For manually hiding a success message if you didn't provide a duration when showing it, or you want to hide it early.
 */
- (void)hideSuccessMessageBelowElement:(MYSFormElement *)element completion:(void (^)(void))completion;

@end




/**
 Allows you to be informed of interesting events that happen with the form.
 */
@protocol MYSFormViewControllerDelegate <NSObject>
@optional
/**
 On every text input before the last, the return key on the iOS keyboard will be "Next", moving them to the next text input field.
 On the last text input field, the return key will be a "Done" button and when pressed, this delegate method will be called, indicating
 the user is done filling out the form. You can call `validate` in this method to make sure all forms are filled out correctly and if
 `validate` returns YES, proceed with processing the model the form populated.
 */
- (void)formViewControllerDidSubmit:(MYSFormViewController *)controller;

/**
 When a change is made and it can't be associated with a model's property (because no `modelKeyPath` was given, or no model is associated
 with the form, this method is called to give you a chance to deal with the value change manually. This is
 useful if you can't associate a model's property with a form element easily and a lot of special case work has to be done to
 get the changed value into a form the model is designed for. This is also useful if you are not using a model with your form, meaning
 the form has no model.
 */
- (void)formViewController:(MYSFormViewController *)controller failedToUpdateModelWithElement:(MYSFormElement *)element;

@end
