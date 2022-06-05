//
//  RestClient.m
//  Ex1
//
//  Created by e4net on 2020/01/15.
//  Copyright © 2020 e4net. All rights reserved.
//

#import "RestClient.h"

@implementation RestClient

- (void)get:(NSInteger)startIndex with:(void(^)(NSArray *))callback {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.10.208:6033/list/%ld", startIndex]]];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        callback(jsonArray);
    }] resume];
}

- (void)post:(NSString *)title with:(NSString *)contents with:(NSString *)img {
    NSDictionary *jsonObject =@{@"title":title, @"contents":contents, @"img":img};
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.10.208:6033/post"]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:jsonObject options:kNilOptions error:nil]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
    }] resume];
    
}

@end
