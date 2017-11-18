//
//  VOJobViewModel.h
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VOJobViewModel : NSObject
@property (strong, nonatomic)  NSString *jobId;
@property (strong, nonatomic)  NSString *jobName;
@property (strong, nonatomic)  NSString *adrStreet;
@property (strong, nonatomic)  NSString *adrZip;
@property (strong, nonatomic)  NSString *adrCity;
@end
