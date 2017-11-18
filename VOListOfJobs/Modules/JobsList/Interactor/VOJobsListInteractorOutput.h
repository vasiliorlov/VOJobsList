//
//  VOJobsListInteractorOutput.h
//  VOListOfJobs
//
//  Created by orlov on 17/11/2017.
//  Copyright © 2017 VO. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VOJob;

@protocol VOJobsListInteractorOutput <NSObject>
-(void)returnLocalJobs:(NSArray<VOJob*> *)jobs error:(NSError *)error;
-(void)returnRemoteJobs:(NSArray<VOJob*> *)jobs error:(NSError *)error;
@end
