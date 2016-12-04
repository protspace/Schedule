//
//  AppDelegate.m
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/2/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//
#pragma GCC diagnostic ignored "-Wundeclared-selector"
#import "AppDelegate.h"
#import "ViewController.h"
#import "WXTabBarController.h"

@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) WXTabBarController *tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    //[self deleteCache];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Navigation Controller

- (UINavigationController *)navigationController {
    if (_navigationController == nil) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.tabBarController];
        navigationController.navigationBar.tintColor = COLOR_WHITE_COLOR;
        navigationController.navigationBar.translucent = NO;
        _navigationController = navigationController;
    }
    return _navigationController;
}

#pragma mark - Tab Bar

- (WXTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        WXTabBarController *tabBarController = [[WXTabBarController alloc] init];
        
        ViewController *airViewController = ({
            ViewController *airViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
            
            UIImage *discoverImage   = [UIImage imageNamed:@"tabbar_discover"];
            UIImage *discoverHLImage = [UIImage imageNamed:@"tabbar_discoverHL"];
            
            airViewController.title = @"Flights";
            airViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Flights" image:discoverImage selectedImage:discoverHLImage];
            airViewController.travelType = TravelTypeAir;
            airViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:airViewController action:@selector(didClickAddButton:)];
            airViewController.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
            UIBarButtonItem *order = [[UIBarButtonItem alloc] initWithTitle:@"⇵" style:UIBarButtonItemStylePlain target:airViewController action:@selector(didClickSortButton:)];
            order.tintColor = [UIColor grayColor];
            UIBarButtonItem *property = [[UIBarButtonItem alloc] initWithTitle:@"departure" style:UIBarButtonItemStylePlain target:airViewController action:@selector(didClickPropertyButton:)];
            property.tintColor = [UIColor grayColor];
            airViewController.navigationItem.leftItemsSupplementBackButton = YES;
            airViewController.navigationItem.leftBarButtonItems = @[property, order];
            airViewController;
        });
        
        ViewController *trainsViewController = ({
            ViewController *trainsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
            
            UIImage *discoverImage   = [UIImage imageNamed:@"tabbar_discover"];
            UIImage *discoverHLImage = [UIImage imageNamed:@"tabbar_discoverHL"];

            trainsViewController.title = @"Trains";
            trainsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Trains" image:discoverImage selectedImage:discoverHLImage];
            trainsViewController.travelType = TravelTypeTrain;
            trainsViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:trainsViewController action:@selector(didClickAddButton:)];
            trainsViewController.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
            UIBarButtonItem *order = [[UIBarButtonItem alloc] initWithTitle:@"⇵" style:UIBarButtonItemStylePlain target:trainsViewController action:@selector(didClickSortButton:)];
            order.tintColor = [UIColor grayColor];
            UIBarButtonItem *property = [[UIBarButtonItem alloc] initWithTitle:@"departure" style:UIBarButtonItemStylePlain target:trainsViewController action:@selector(didClickPropertyButton:)];
            property.tintColor = [UIColor grayColor];
            trainsViewController.navigationItem.leftItemsSupplementBackButton = YES;
            trainsViewController.navigationItem.leftBarButtonItems = @[property, order];
            trainsViewController;
        });
        
        ViewController *busesViewController = ({
            ViewController *busesViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
            UIImage *discoverImage   = [UIImage imageNamed:@"tabbar_discover"];
            UIImage *discoverHLImage = [UIImage imageNamed:@"tabbar_discoverHL"];
            
            busesViewController.title = @"Buses";
            busesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Buses" image:discoverImage selectedImage:discoverHLImage];
            busesViewController.travelType = TravelTypeBus;
            busesViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:busesViewController action:@selector(didClickAddButton:)];
            busesViewController.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
            UIBarButtonItem *order = [[UIBarButtonItem alloc] initWithTitle:@"⇵" style:UIBarButtonItemStylePlain target:busesViewController action:@selector(didClickSortButton:)];
            order.tintColor = [UIColor grayColor];
            UIBarButtonItem *property = [[UIBarButtonItem alloc] initWithTitle:@"departure" style:UIBarButtonItemStylePlain target:busesViewController action:@selector(didClickPropertyButton:)];
            property.tintColor = [UIColor grayColor];
            busesViewController.navigationItem.leftItemsSupplementBackButton = YES;
            busesViewController.navigationItem.leftBarButtonItems = @[property, order];
            busesViewController;
        });
        
        
        
        tabBarController.title = @"tabbar";
        tabBarController.tabBar.tintColor = [UIColor colorWithRed:26 / 255.0 green:178 / 255.0 blue:10 / 255.0 alpha:1];
        tabBarController.tabBar.translucent = NO;
        UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:airViewController];
        nav1.navigationBar.tintColor = COLOR_WHITE_COLOR;
        nav1.navigationBar.translucent = NO;
        UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:trainsViewController];
        nav2.navigationBar.tintColor = COLOR_WHITE_COLOR;
        nav2.navigationBar.translucent = NO;
        UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:busesViewController];
        nav3.navigationBar.tintColor = COLOR_WHITE_COLOR;
        nav3.navigationBar.translucent = NO;
        tabBarController.viewControllers = @[nav1, nav2, nav3];
        
        _tabBarController = tabBarController;
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: COLOR_GREEN_COLOR}];
    }
    return _tabBarController;
}


#pragma mark - Cache

-(void) deleteCache {
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *localFileManager=[[NSFileManager alloc] init];
    NSDirectoryEnumerator *dirEnum = [localFileManager enumeratorAtPath:docsDir];
    
    NSString *file;
    NSError *error;
    while ((file = [dirEnum nextObject]))
    {
        NSString *fullPath = [NSString stringWithFormat:@"%@/%@", docsDir,file];
        // process the document
        [localFileManager removeItemAtPath: fullPath error:&error ];
    }
}

@end
