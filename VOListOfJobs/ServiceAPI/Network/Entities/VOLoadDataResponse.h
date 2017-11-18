//
//  VOLoadDataResponse.h
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VOServerPesponse.h"
#import "VOJob.h"

@interface VOLoadDataResponse : VOServerPesponse
@property (nonatomic, strong)      NSArray<VOJob*>  *jobs;
@property (nonatomic, assign)      int               total;

@end
