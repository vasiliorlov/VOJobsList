//
//  VOJobs.h
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VOAdress;

@interface VOJob : NSObject
@property (nonatomic, strong)      NSString *workAssignmentId;
@property (nonatomic, strong)      NSString *workAssignmentName;
@property (nonatomic, strong)      VOAdress *adress;
@end
