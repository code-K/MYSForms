//
//  MYSFormImagePickerElement.m
//  MYSForms
//
//  Created by Adam Kirk on 5/10/14.
//  Copyright (c) 2014 Mysterious Trousers. All rights reserved.
//

#import "MYSFormImagePickerElement.h"
#import "MYSFormImagePickerCell-Private.h"


NSString * const MYSFormImagePickerCellActionSheetButtonTakePhoto           = @"Take Photo";
NSString * const MYSFormImagePickerCellActionSheetButtonChooseFromLibrary   = @"Choose From Library";
NSString * const MYSFormImagePickerCellActionSheetButtonCancel              = @"Cancel";
NSString * const MYSFormImagePickerCellActionSheetButtonRemovePhoto         = @"Remove Photo";


@interface MYSFormImagePickerElement () <MYSFormImagePickerCellDelegate,
                                         UIActionSheetDelegate,
                                         UIImagePickerControllerDelegate,
                                         UINavigationControllerDelegate>
@end


@implementation MYSFormImagePickerElement

+ (instancetype)imagePickerElementWithLabel:(NSString *)label modelKeyPath:(NSString *)modelKeyPath
{
    MYSFormImagePickerElement *element  = [MYSFormImagePickerElement new];
    element.label                       = label;
    element.modelKeyPath                = modelKeyPath;
    return element;
}

- (void)setCell:(MYSFormImagePickerCell *)cell
{
    [super setCell:cell];
    cell.imagePickerCellDelegate = self;
}




#pragma mark - DELEGATE image picker cell

- (void)formImagePickerCellWasTapped:(MYSFormImagePickerCell *)cell
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actionSheet addButtonWithTitle:MYSFormImagePickerCellActionSheetButtonTakePhoto];
    }
    [actionSheet addButtonWithTitle:MYSFormImagePickerCellActionSheetButtonChooseFromLibrary];

    if (cell.imageView.image) {
        actionSheet.destructiveButtonIndex =
        [actionSheet addButtonWithTitle:MYSFormImagePickerCellActionSheetButtonRemovePhoto];
    }

    actionSheet.cancelButtonIndex =
    [actionSheet addButtonWithTitle:MYSFormImagePickerCellActionSheetButtonCancel];

    [self.delegate formElement:self didRequestPresentationOfActionSheet:actionSheet];
}




#pragma mark - DELEGATE action sheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.delegate = self;

    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:MYSFormImagePickerCellActionSheetButtonTakePhoto]) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if ([buttonTitle isEqualToString:MYSFormImagePickerCellActionSheetButtonChooseFromLibrary]) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else if ([buttonTitle isEqualToString:MYSFormImagePickerCellActionSheetButtonRemovePhoto]) {
        [self updateCell];
        [self.delegate formElement:self valueDidChange:nil];
        return;
    }
    else if ([buttonTitle isEqualToString:MYSFormImagePickerCellActionSheetButtonCancel]) {
        return;
    }

    [self.delegate formElement:self didRequestPresentationOfViewController:imagePickerController animated:YES completion:nil];
}




#pragma mark - DELEGATE image picker

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage] ?: info[UIImagePickerControllerOriginalImage];
    [self updateCell];
    [self.delegate formElement:self valueDidChange:image];
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
