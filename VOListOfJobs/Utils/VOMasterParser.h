//
//  VOMasterParser.h
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VOJobViewModel, VOJob;

@interface VOMasterParser : NSObject
+(NSArray<VOJobViewModel*>*)viewModelsFromJobs:(NSArray<VOJob*>*) jobs;
@end
