//
//  VOJobsListInteractorInput.h
//  VOListOfJobs
//
//  Created by orlov on 17/11/2017.
//  Copyright © 2017 VO. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VOJob;
@protocol VOJobsListInteractorInput <NSObject>
-(void)getLocalJobs;
-(void)getRemoteJobs;
@end
