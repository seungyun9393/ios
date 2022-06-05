//
//  MainViewController.m
//  Ex1
//
//  Created by e4net on 2020/01/15.
//  Copyright © 2020 e4net. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewCell.h"
#import "../REST/RestClient.h"
#import "DetailViewController.h"
#import "PostViewController.h"

@interface MainViewController () {
    NSMutableArray* data;
    RestClient *client;
    NSDate* requestStart;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    data = [[NSMutableArray alloc] init];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 2)];
    footerView.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.0f];
    self.tableView.tableFooterView= footerView;
    
    client = [[RestClient alloc] init];
    [self addDataByIndex:0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 90.0f;
}

- (TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tableViewIdentifier = @"tableViewIdentifier";
    NSInteger index =indexPath.row;
    
    TableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier];
    
    if(!tableCell) {
        tableCell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    NSDictionary* targetData = [data objectAtIndex:index];
    
    
    //[targetData objectForKey:@"img"];
    NSString* base64String = [NSString stringWithFormat:@"%@%@", @"data:image/png;base64,", [targetData objectForKey:@"img"]];
    
    UIImage* image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:base64String]]];
    
    CGRect rect = CGRectMake(0, 0, 109, 69);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *rimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [tableCell.imgView setImage:rimage];
    [tableCell.title setText:[targetData objectForKey:@"title"]];
    [tableCell.contents setText:[targetData objectForKey:@"contents"]];
    
    
    return tableCell;
}


- (IBAction)compose:(id)sender {
    PostViewController* postViewController = [[PostViewController alloc] initWithNibName:@"PostViewController" bundle:nil];
    postViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:postViewController animated:YES completion:nil];
}


- (void) addDataByIndex:(NSInteger)index {
    requestStart = [NSDate date];
    
    [client get:index with:^(NSArray * _Nonnull array){
        [self -> data addObjectsFromArray:array];
        
        dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
        });
    }];
}

- (void)scrollViewDidScroll:(UITableView *)tableView {
    CGFloat height = tableView.frame.size.height;
    CGFloat contentYOffset = tableView.contentOffset.y;
    CGFloat distanceFromBottom = tableView.contentSize.height - contentYOffset;
    
    if(distanceFromBottom < height) {
        [self tryRequest];
    }
}

- (void) tryRequest {
    NSTimeInterval elapsedTime = -[requestStart timeIntervalSinceNow];
    if(elapsedTime < 2) {
        return;
    } else {
        [self addDataByIndex:[data count]];
        requestStart = [NSDate date];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSDictionary* tci = [data objectAtIndex:indexPath.row];
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detailViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:detailViewController animated:YES completion:nil];
    [detailViewController initWithTCI:tci];
}




@end
