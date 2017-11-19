//
//  VOJobTableViewCell.h
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VOJobViewModel.h"

@interface VOJobTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblJobName;
@property (strong, nonatomic) IBOutlet UILabel *lblAdrStreet;
@property (strong, nonatomic) IBOutlet UILabel *lblAdrZip;
@property (strong, nonatomic) IBOutlet UILabel *lblAdrCity;
@end
