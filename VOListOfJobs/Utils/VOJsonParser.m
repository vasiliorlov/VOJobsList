//
//  VOJsonParser.m
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import "VOJsonParser.h"
#import "VOLoadDataResponse.h"

@implementation NSDictionary (RDJson)

- (id)valueForKeyNullCheck:(NSString *)key {
    id value = [self valueForKey:key];
    if ([value isEqual:[NSNull null]]) {
        return nil;
    }
    else if ([value isKindOfClass:[NSString class]]) {
        __block NSMutableString *string = [(NSString *)value mutableCopy];
        //&gt; и &lt для ><
        NSDictionary *htmlReplacementDict = @{ @"&amp;":@"&", @"&gt;":@">", @"&lt;":@"<" };
        [htmlReplacementDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            [string replaceOccurrencesOfString:key withString:obj options:0 range:NSMakeRange(0, string.length)];
        }];
        return string;
    }
    else {
        return value;
    }
}

@end

@implementation VOJsonParser
- (VOLoadDataResponse *)parseServerResponse:(NSDictionary *)jLoadDataResponse
{
    VOLoadDataResponse * loadDataResponse = [[VOLoadDataResponse alloc] init];
    
    loadDataResponse.isError      = [jLoadDataResponse[@"error"] boolValue];
    loadDataResponse.status      = [jLoadDataResponse[@"status"] intValue];
    loadDataResponse.errorCode     = [jLoadDataResponse valueForKeyNullCheck:@"errorCode"];

    
    return loadDataResponse;
}

- (VOLoadDataResponse *)parseLoadDataResponse:(NSDictionary *)jLoadDataResponse
{
    VOLoadDataResponse * loadDataResponse = [[VOLoadDataResponse alloc] init];
    NSDictionary *data = jLoadDataResponse[@"data"];
    NSMutableArray *jobs = [[NSMutableArray alloc] init];
    if (data != nil){
        NSArray *items = data[@"items"];
        if (items.count > 0){
            for (NSDictionary *item in items) {
                VOJob *job = [[VOJob alloc] init];
                job.workName = item[@"workAssignmentName"];
                job.workId = item[@"workAssignmentName"];
                
                NSDictionary *location = jLoadDataResponse[@"jobLocation"];
            
                VOAdress *adress = [[VOAdress alloc] init];
                adress.street = location[@"addressStreet"];
                adress.zip = location[@"zip"];
                adress.city = location[@"city"];
                
                job.adress = adress;
                [jobs addObject:job];
            }
        }
        loadDataResponse.jobs = jobs;
        loadDataResponse.total = [data[@"total"] unsignedIntegerValue];
    }

    
    
    return loadDataResponse;
}
@end
