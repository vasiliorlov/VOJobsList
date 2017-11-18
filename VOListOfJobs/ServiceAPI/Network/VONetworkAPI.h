//
//  VONetworkAPI.h
//  VOListOfJobs
//
//  Created by iMac on 17.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VOLoadDataResponse;

@protocol VONetworkAPI <NSObject>
- (void)getJobsWithCompleteHandler:(void(^)(VOLoadDataResponse * response, NSError * error))completeHandler;
@end
