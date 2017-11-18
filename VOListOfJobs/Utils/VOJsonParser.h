//
//  VOJsonParser.h
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VOLoadDataResponse, VOServerPesponse;
@interface VOJsonParser : NSObject
- (VOServerPesponse *)parseServerResponse:(NSDictionary *)jLoadDataResponse;
- (VOLoadDataResponse *)parseLoadDataResponse:(NSDictionary *)jLoadDataResponse;

@end
