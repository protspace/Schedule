//
//  TripTableViewCell.h
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/4/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *departure;
@property (weak, nonatomic) IBOutlet UILabel *arrival;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *type;

@end
