//
//  VOServiceCommunication.h
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VOServiceCommunication <NSObject>
- (void)sendData:(NSDictionary *)params
   serviceMethod:(NSString *)serviceMethod
 completeHandler:(void (^)(NSDictionary *jsonData, NSError *error))completeHandler;
@end
