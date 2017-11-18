//
//  VODataBase.h
//  VOListOfJobs
//
//  Created by iMac on 18.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface VODataBase : NSObject
@property (nonatomic, copy) NSString *databasePath;
@property (nonatomic, strong, readonly) NSObject *databaseMutex;
@property (nonatomic, assign) BOOL databaseOpened;
@property (nonatomic, unsafe_unretained) sqlite3 *sqliteDatabase;

+ (instancetype)sharedInstance;
- (NSString *)getDatabaseAddress;

- (BOOL)openDatabaseReadOnly:(BOOL)readOnly;
- (void)closeDatabase;

- (void)startTransaction;
- (void)commitTransaction;


- (BOOL)isDatabaseCreated;
- (BOOL)createDatabase;
- (void)clearData;


@end
