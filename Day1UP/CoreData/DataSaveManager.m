//
//  DataSaveManager.m
//  Day1UP
//
//  Created by ramborange on 16/10/9.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "DataSaveManager.h"

#define Data_Save_Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"mydata.sqlite"]

@implementation DataSaveManager
static DataSaveManager *manager = nil;
+ (DataSaveManager *)shareDataSaveManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager==nil) {
            manager = [[DataSaveManager alloc] init];
        }
    });
    return manager;
}

- (void)dealloc {
    _context = nil;
    _results = nil;
    NSLog(@"%s",__func__);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initCoreData];
    }
    return self;
}

- (void)initCoreData {
    NSURL *url = [NSURL URLWithString:Data_Save_Path];
    NSManagedObjectModel *objectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *persisrentStroreCoo = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:objectModel];
    NSDictionary *opitionsDic = [NSDictionary dictionaryWithObjectsAndKeys:@(YES),NSMigratePersistentStoresAutomaticallyOption,@(YES),NSInferMappingModelAutomaticallyOption, nil];
    NSError *error;
    NSPersistentStore *persistentStore = [persisrentStroreCoo addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:opitionsDic error:&error];
    if (persistentStore!=nil) {
        self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [self.context setPersistentStoreCoordinator:persisrentStroreCoo];
    }else {
        NSLog(@"error:%@",[error localizedDescription]);
    }
}

- (void)addTest:(Test *)test {
    TestModel *model = [self getTestMoelWith:test.tid];
    if (model) {
        [self removeTest:model];
    }
    TestModel *testModel = [NSEntityDescription insertNewObjectForEntityForName:@"TestModel" inManagedObjectContext:self.context];
    testModel.tid = test.tid;
    testModel.arg = test.arg;
    testModel.other = test.other;
    NSError *error;
    BOOL ret = [self.context save:&error];
    if (!ret) {
        NSLog(@"error:%@",[error localizedDescription]);
    }
}

- (void)removeTest:(TestModel *)testModel {
    [self.context deleteObject:testModel];
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"error:%@",[error localizedDescription]);
    }
}

- (void)removeAllTests {
    NSArray *models = [self getAllTests];
    for (TestModel *model in models) {
        [self removeTest:model];
    }
}

- (TestModel *)getTestMoelWith:(NSString *)tid {
    NSFetchRequest *fetchRequest = [NSFetchRequest init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"TestModel" inManagedObjectContext:self.context]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tid" ascending:NO];
    NSArray *array = [NSArray arrayWithObject:sortDescriptor];
    [fetchRequest setSortDescriptors:array];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tid == %@",tid];
    [fetchRequest setPredicate:predicate];
    
    self.results = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
    self.results.delegate = self;
    NSError *error;
    BOOL ret = [self.results performFetch:&error];
    if (!ret) {
        NSLog(@"fetch error:%@",[error localizedDescription]);
    }
    
    NSArray *results = self.results.fetchedObjects;
    if (results.count) {
        return [results firstObject];
    }
    return nil;
}

- (NSArray *)getAllTests {
    [NSFetchedResultsController deleteCacheWithName:@"TestCache"];
    self.results = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"TetsModel" inManagedObjectContext:self.context]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tid" ascending:YES];
    NSArray *sorts = [NSArray arrayWithObject:sortDescriptor];
    [fetchRequest setSortDescriptors:sorts];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tid != nil"];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
//    NSArray *array = [self.context executeFetchRequest:fetchRequest error:&error];
//    if (array==nil) {
//        NSLog(@"error:%@",error);
//    }else {
//        if (array.count) {
//            return array;
//        }else {
//            return nil;
//        }
//    }
    self.results = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:@"TestCache"];
    BOOL ret = [self.results performFetch:&error];
    if (!ret) {
        NSLog(@"error:%@",[error localizedDescription]);
    }
    NSArray *array = self.results.fetchedObjects;
    if (array.count) {
        return array;
    }
    return nil;
}

- (void)saveUpdate {
    if (_context) {
        if ([_context hasChanges]) {
            NSError *error;
            BOOL ret = [_context save:&error];
            if (!ret) {
                NSLog(@"error:%@",error);
            }
        }
    }
}

#pragma mark - NSFetchResultsController Delegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {

}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {

}

@end
