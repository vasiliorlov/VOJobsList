//
//  VOJobs.h
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VOAdress.h"

@interface VOJob : NSObject
@property (nonatomic, strong)      NSString *workId;
@property (nonatomic, strong)      NSString *workName;
@property (nonatomic, strong)      VOAdress *adress;
@end
