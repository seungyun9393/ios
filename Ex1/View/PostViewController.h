//
//  PostViewController.h
//  Ex1
//
//  Created by e4net on 2020/01/16.
//  Copyright © 2020 e4net. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostViewController : UIViewController <UIImagePickerControllerDelegate>
- (IBAction)back:(id)sender;
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UITextView *contents;
@property (weak, nonatomic) IBOutlet UITextView *mainTitle;
- (IBAction)selectImage:(id)sender;

@end

NS_ASSUME_NONNULL_END
