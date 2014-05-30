//
//  AppDelegate.m
//  AFNetworing
//
//  Created by YunInfo on 14-5-30.
//  Copyright (c) 2014年 BBA. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworkActivityLogger.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLSessionManager.h"
#import "MUResponseSerializer.h"
#import "DataObject.h"

@implementation AppDelegate

- (void)post:(AFHTTPRequestOperationManager *)manager
{
    /*
     [manager GET:@"http://mapi.baobeian.cn/parent_yuer_list" parameters:@{ @"lfrom": @"2",
     @"page": @"1",
     @"parentid":  @"10021601",
     @"schoolid" : @"10002",
     @"uid" : @"100216"}
     success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
     NSLog(@"JSON: %@", responseObject);
     }
     
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     
     {
     NSLog(@"Error: %@", error);
     }];
     */
    
    
    NSDictionary *parameters = @{ @"lfrom": @"2",
                                  @"page": @"1",
                                  @"parentid":  @"10021601",
                                  @"schoolid" : @"10002",
                                  @"uid" : @"100216"};
    [manager POST:@"http://mapi.baobeian.cn/parent_yuer_list" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //启用网络请求日志
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelError];
    // Override point for customization after application launch.
    
    
    //GET REQUEST
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[[MUResponseSerializer alloc] initWithResponseClass:[da class]]];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [self post:manager];
   // [self downLoadTask];
    
    return YES;
}

-(void)downLoadTask
{

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"https://www.gravatar.com/avatar/292d20a12747d59655871c3ecc2503c8?s=32&d=identicon&r=PG"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
