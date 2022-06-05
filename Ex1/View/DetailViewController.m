//
//  DetailViewController.m
//  Ex1
//
//  Created by e4net on 2020/01/16.
//  Copyright © 2020 e4net. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) initWithTCI:(NSDictionary *)tci {
    
    NSString* base64String = [NSString stringWithFormat:@"%@%@", @"data:image/png;base64,", [tci objectForKey:@"img"]];
    UIImage* image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:base64String]] scale:1.0f];

    
    [_detailImageView setImage:image];
    [_detailTitleTextView setText:[tci objectForKey:@"title"]];
    [_detailContentsTextView setText:[tci objectForKey:@"contents"]];
}
@end
