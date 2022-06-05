//
//  DetailViewController.h
//  Ex1
//
//  Created by e4net on 2020/01/16.
//  Copyright © 2020 e4net. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *detailTitle;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UITextView *detailTitleTextView;
@property (weak, nonatomic) IBOutlet UITextView *detailContentsTextView;

- (void) initWithTCI:(NSDictionary *)tci;
@end

NS_ASSUME_NONNULL_END
