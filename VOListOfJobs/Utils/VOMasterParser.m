//
//  VOMasterParser.m
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import "VOMasterParser.h"
#import "VOJobViewModel.h"
#import "VOJob.h"

@implementation VOMasterParser

+(NSArray<VOJobViewModel*>*)viewModelsFromJobs:(NSArray<VOJob*>*) jobs{
    NSMutableArray<VOJobViewModel*>* models = [[NSMutableArray alloc] init];
    for (VOJob *job in jobs) {
        VOJobViewModel *model = [[VOJobViewModel alloc] init];
        model.jobId = job.workId;
        model.jobName = job.workName;
        model.adrStreet = job.adress.street;
        model.adrZip = job.adress.zip;
        model.adrCity = job.adress.city;
        [models addObject:model];
    }
    return models;
}
@end
