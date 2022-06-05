//
//  PostViewController.m
//  Ex1
//
//  Created by e4net on 2020/01/16.
//  Copyright © 2020 e4net. All rights reserved.
//

#import "PostViewController.h"
#import "RestClient.h"

@interface PostViewController () {
    UIImagePickerController* imagePicker;
    RestClient* client;
}


@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = (id)self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    client = [[RestClient alloc] init];
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
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [self.mainImage setImage:info[UIImagePickerControllerOriginalImage]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSData *imageData = UIImagePNGRepresentation([self resize:self.mainImage.image]);

    [client post:[_mainTitle text] with:[_contents text] with:[imageData base64EncodedStringWithOptions:kNilOptions]];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)selectImage:(id)sender {
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (UIImage *) resize:(UIImage *)image {
    CGFloat newWidth = image.size.width, newHeight = image.size.height;
    if(image.size.width >= 512 ) {
        newHeight = newHeight / newWidth * 512;
        newWidth = 512;
    }
    if(newHeight >=384) {
        newWidth = newWidth / newHeight * 384;
        newHeight = 384;
    }
    CGRect rect = CGRectMake(0, 0, newWidth, newHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *rimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return rimage;
}
@end
