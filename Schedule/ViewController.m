//
//  ViewController.m
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/2/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//


#import "ViewController.h"
#import <Realm/Realm.h>
#import "TripRealm.h"
#import "TripsListResponseModel.h"
#import "APIManager.h"
#import "TripTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+Custom.h"
#import "SVProgressHUD.h"
#import "Schedule-Swift.h"

static NSString *const kTripTableViewCellIdentifier = @"TripTableViewCellIdentifier";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) RLMResults *trips;
@property (nonatomic, strong) NSString *sortingProperty;
@property BOOL sortingOrder;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sortingProperty = @"departure";
    self.sortingOrder = NO;
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [self.tableView registerNib:[UINib nibWithNibName:@"TripTableViewCell" bundle:nil]  forCellReuseIdentifier:kTripTableViewCellIdentifier];
   
    [self getTrips];

    DGElasticPullToRefreshLoadingView *loadingView = [[DGElasticPullToRefreshLoadingViewCircle alloc] init];
    loadingView.tintColor = COLOR_WHITE_COLOR;
    [self.tableView dg_addPullToRefreshWithActionHandler:^{
        [self getTrips];
    } loadingView:loadingView];
    [self.tableView dg_setPullToRefreshFillColor:[UIColor lightGrayColor]];
    [self.tableView dg_setPullToRefreshBackgroundColor:self.tableView.backgroundColor];

}


- (void) viewWillDisappear:(BOOL)animated {
    if (self.tableView) {
        [self.tableView dg_removePullToRefresh];
    }
}

-(void) dealloc {
    if (self.tableView) {
        [self.tableView dg_removePullToRefresh];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) getTrips {
    __weak typeof(self) weakSelf = self;
    [[APIManager sharedManager] getTripsForType:self.travelType success:^(TripsListResponseModel *responseModel) {
        [self setDefaultRealmForTravelType:self.travelType];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteAllObjects];
        [realm commitWriteTransaction];
        
        [realm beginWriteTransaction];
        for(TripModel *trip in responseModel.trips){
            TripRealm *tripRealm = [[TripRealm alloc] initWithMantleModel:trip];
            [realm addObject:tripRealm];
        }
        [realm commitWriteTransaction];
        NSLog(@" responseModel.trips = %lu",  (unsigned long)responseModel.trips.count);
        [weakSelf reloadData];
    } failure:^(NSError *error) {
        [weakSelf reloadData];
    }];
}

- (void) reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setDefaultRealmForTravelType:self.travelType];
        RLMRealm *realmMainThread = [RLMRealm defaultRealm];
        //[realmMainThread refresh];
        RLMResults *trips = [TripRealm allObjectsInRealm:realmMainThread];
        self.trips = [trips sortedResultsUsingProperty:self.sortingProperty ascending:YES];
        NSLog(@"Here are all trips for %@: %lu", [self convertTypeToString:self.travelType],(unsigned long)self.trips.count);
        [self.tableView reloadData];
        [self.tableView dg_stopLoading];
    });
}

- (NSString *) convertTypeToString:(TravelType)type {
    NSString *result = nil;
    
    switch(type) {
        case TravelTypeBus:
            result = @"bus";
            break;
        case TravelTypeAir:
            result = @"air";
            break;
        case TravelTypeTrain:
            result = @"train";
            break;
        default:
            result = @"unknown";
    }
    
    return result;
}

- (void)setDefaultRealmForTravelType:(TravelType)travelType {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    // Use the default directory, but replace the filename with the username
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent]
                       URLByAppendingPathComponent:[self convertTypeToString:travelType]]
                      URLByAppendingPathExtension:@"realm"];
    // Set this as the configuration used for the default Realm
    [RLMRealmConfiguration setDefaultConfiguration:config];
}


#pragma mark Actions

- (void)didClickAddButton:(id)sender {
    [SVProgressHUD showErrorWithStatus:@"Offer details are not yet implemented!"];
}


- (void) didClickSortButton:(id)sender {
    self.sortingOrder = !self.sortingOrder;
    self.trips = [self.trips sortedResultsUsingProperty:self.sortingProperty ascending:self.sortingOrder];
    NSLog(@"Here are all trips for %@: %lu", [self convertTypeToString:self.travelType],(unsigned long)self.trips.count);
    [self.tableView reloadData];
}

- (void) didClickPropertyButton:(id)sender {
    self.sortingOrder = NO;
    if ([self.sortingProperty isEqualToString:@"departure"]) {
        self.sortingProperty = @"arrival";
    } else if ([self.sortingProperty isEqualToString:@"arrival"]) {
        self.sortingProperty = @"duration";
    } else {
        self.sortingProperty = @"departure";
        self.sortingOrder = YES;
    }
    self.trips = [self.trips sortedResultsUsingProperty:self.sortingProperty ascending:self.sortingOrder];
    NSLog(@"Here are all trips for %@: %lu", [self convertTypeToString:self.travelType],(unsigned long)self.trips.count);
    [self.tableView reloadData];
    UIBarButtonItem *propertyItem = self.navigationItem.leftBarButtonItems[0];
    if (propertyItem) {
        [UIView animateWithDuration:0.2f animations:^{
            propertyItem.title = self.sortingProperty;
        }];
    }
}

#pragma mark UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.trips count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    TripRealm *trip = [self.trips objectAtIndex:row];

    TripTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTripTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[TripTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kTripTableViewCellIdentifier];
    }
    
    cell.price.text = trip.priceEur != nil ? [NSString stringWithFormat:@"€%@", trip.priceEur.stringValue] : @"";
    cell.departure.text = trip.departure;
    cell.arrival.text = trip.arrival;
    cell.duration.text = trip.duration;
    
    cell.logo.image = nil;
    if (trip.providerLogo) {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:trip.providerLogo]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {}
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (image) {
                                    UIImage *newImage = [image compressedImageWithMaxLength: 150 quality: 1.0];
                                    cell.logo.image = newImage;
                                }
                            }];
    }
    
    cell.type.text = trip.numberOfStops.intValue == 0 ? @"Direct" : @"";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}



@end
