//
//  VODataStoreAPIImpl.m
//  VOListOfJobs
//
//  Created by iMac on 17.11.2017.
//  Copyright © 2017 VasiliOrlovCo. All rights reserved.
//

#import "VODataStoreAPIImpl.h"
#import "VODataBase.h"
#import "VODataBaseConst.h"
#import "VOJob.h"

@implementation VODataStoreAPIImpl


- (void)saveJobs:(NSArray<VOJob*> *)jobs{
    VODataBase *database = [VODataBase sharedInstance];
    
    @synchronized(database.databaseMutex)
    {
        [database openDatabaseReadOnly:NO];
        [database startTransaction];
        
        sqlite3 *db = database.sqliteDatabase;
        
        NSString *save_job_sql = [NSString stringWithFormat:
                                  @"INSERT OR REPLACE INTO %s (%s, %s, %s, %s, %s)"
                                  "VALUES (?, ?, ?, ?, ?)",
                                  Db_Table_Jobs, Db_Field_Jobs_Id, Db_Field_Jobs_Name, Db_Field_Jobs_Adr_Street, Db_Field_Jobs_Adr_Zip, Db_Field_Jobs_Adr_City
                                  ];
        
        sqlite3_stmt *save_job_stmt = nil;
        int state = sqlite3_prepare_v2(db, [save_job_sql UTF8String], -1, &save_job_stmt, NULL);
        NSAssert(state == SQLITE_OK, @"Can't prepare statement for sql %@", save_job_sql);
        
        
        for (VOJob *job in jobs)
        {
            bindSaveJobStatement(save_job_stmt, job);
            state = sqlite3_step(save_job_stmt);
            NSAssert(state == SQLITE_DONE, @"Can't save job %@ with sql %@", job, save_job_sql);
            
            sqlite3_reset(save_job_stmt);
        }
        
        sqlite3_finalize(save_job_stmt);
        
        [database commitTransaction];
        [database closeDatabase];
    }
}

static void bindSaveJobStatement(sqlite3_stmt * save_job_stmt, VOJob * job)
{
    sqlite3_bind_text(save_job_stmt, 1, [job.workId UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(save_job_stmt, 2, [job.workName UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(save_job_stmt, 3, [job.adress.street UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(save_job_stmt, 4, [job.adress.zip UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(save_job_stmt, 5, [job.adress.city UTF8String], -1, SQLITE_TRANSIENT);
    
}
- (NSArray<VOJob*> *)readAllJobs{
    VODataBase * database = [VODataBase sharedInstance];
    
    @synchronized(database.databaseMutex)
    {
        [database openDatabaseReadOnly:YES];
        NSString *sql_job = [NSString stringWithFormat:@"SELECT * FROM %s", Db_Table_Jobs];
        sqlite3 *db = database.sqliteDatabase;
        sqlite3_stmt *job_stmt = nil;
        int state = sqlite3_prepare_v2(db, sql_job.UTF8String, -1, &job_stmt, NULL);
        NSAssert(state == SQLITE_OK, @"Can't create statement for %@, err: %s", sql_job, sqlite3_errmsg(db));
        NSArray * jobs = [self _getJobsByStatement:job_stmt];
        
        sqlite3_finalize(job_stmt);
        [database closeDatabase];
        return jobs;
    }
}
- (NSArray *)_getJobsByStatement:(sqlite3_stmt *)stmt
{
    NSMutableArray *result = [NSMutableArray array];
    
    while(sqlite3_step(stmt) == SQLITE_ROW)
    {
        int fieldNumber = sqlite3_column_count(stmt);
        VOJob *job = [[VOJob alloc] init];
        VOAdress *adress = [[VOAdress alloc] init];
        job.adress = adress;
        
        for (int i = 0; i < fieldNumber; i++)
        {
            const char *cn = (char *)sqlite3_column_name(stmt, i);
            if (cn != NULL)
            {
                if (strcmp(cn, Db_Field_Jobs_Id) == 0) {
                    const char * d = (char *)sqlite3_column_text(stmt, i);
                    if (d != NULL) {
                        job.workId = [NSString stringWithCString:d encoding:NSUTF8StringEncoding];
                    }
                } else  if (strcmp(cn, Db_Field_Jobs_Name) == 0) {
                    const char * d = (char *)sqlite3_column_text(stmt, i);
                    if (d != NULL) {
                        job.workName = [NSString stringWithCString:d encoding:NSUTF8StringEncoding];
                    }
                }
                else  if (strcmp(cn, Db_Field_Jobs_Adr_Street) == 0) {
                    const char * d = (char *)sqlite3_column_text(stmt, i);
                    if (d != NULL) {
                        adress.street = [NSString stringWithCString:d encoding:NSUTF8StringEncoding];
                    }
                }
                else if (strcmp(cn, Db_Field_Jobs_Adr_Zip) == 0) {
                    const char * d = (char *)sqlite3_column_text(stmt, i);
                    if (d != NULL) {
                        adress.zip = [NSString stringWithCString:d encoding:NSUTF8StringEncoding];
                    }
                }
                else if (strcmp(cn, Db_Field_Jobs_Adr_City) == 0) {
                    const char * d = (char *)sqlite3_column_text(stmt, i);
                    if (d != NULL) {
                        adress.city = [NSString stringWithCString:d encoding:NSUTF8StringEncoding];
                    }
                }
                
            } //obtaining fields
        }
        [result addObject:job];
    }
    return result;
}
- (void)clearAllJobs{
    VODataBase * database = [VODataBase sharedInstance];
    @synchronized(database.databaseMutex)
    {
        [database openDatabaseReadOnly:NO];
        [database startTransaction];
        
        const char * tables_to_clear[] = { Db_Table_Jobs};
        int tables_number = sizeof(tables_to_clear) / sizeof(const char *);
        int state = 0;
        
        for (int i = 0; i < tables_number; i++)
        {
            const char * table_name = tables_to_clear[i];
            NSString * sql = [NSString stringWithFormat:@"DELETE FROM %s", table_name];
            state = sqlite3_exec(database.sqliteDatabase, [sql UTF8String], 0, 0, 0);
            NSAssert(state == SQLITE_OK, @"%s: sql \"%@\" %s", __FUNCTION__, sql, sqlite3_errmsg(database.sqliteDatabase));
        }
        
        [database commitTransaction];
        [database closeDatabase];
    }
}
@end
