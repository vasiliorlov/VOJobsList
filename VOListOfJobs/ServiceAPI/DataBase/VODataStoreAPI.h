//
//  VODataStoreAPI.h
//  VOListOfJobs
//
//  Created by iMac on 17.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VOJob, VOLoadDataResponse;
@protocol VODataStoreAPI <NSObject>
- (void)saveJobs:(NSArray<VOJob*> *)jobs;
- (NSArray<VOJob*> *)readAllJobs;
- (void)clearAllJobs;
@end
