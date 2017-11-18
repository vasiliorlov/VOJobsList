//
//  VOJobTableViewCell.m
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import "VOJobTableViewCell.h"
@interface VOJobTableViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *lblJobName;
@property (strong, nonatomic) IBOutlet UILabel *lblAdrStreet;
@property (strong, nonatomic) IBOutlet UILabel *lblAdrZip;
@property (strong, nonatomic) IBOutlet UILabel *lblAdrCity;
@end

@implementation VOJobTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupStateWithModel:(VOJobViewModel*)model{
    _lblJobName.text    = model.jobName;
    _lblAdrStreet.text  = model.adrStreet;
    _lblAdrZip.text     = model.adrZip;
    _lblAdrCity.text    = model.adrCity;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
