//
//  AcessoDB.m
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "ColaboradorDB.h"
#import <CoreData/CoreData.h>

@interface ColaboradorDB()

@property (readonly, nonatomic, strong) NSManagedObjectModel *model;
@property (readonly, nonatomic, strong) NSPersistentStoreCoordinator *coordinator;
@property (readonly, nonatomic, strong) NSManagedObjectContext *contexto;

@end

@implementation ColaboradorDB

@synthesize model = _model;
@synthesize coordinator = _coordinator;
@synthesize contexto = _contexto;

static ColaboradorDB *instance;

#define TABLE @"Colaborador"

+ (ColaboradorDB *) sharedInstance {
    if (instance == nil) instance = [[ColaboradorDB alloc]init];
    return instance;
}

#pragma mark - CoreData objetcs
- (NSManagedObjectModel *) model{
    if (_model == nil){
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"cardapio" withExtension:@"momd"];
        _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    }
    return _model;
}

- (NSPersistentStoreCoordinator *) coordinator {
    if (_coordinator == nil){
        _coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.model];
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Colaborador.db"];
        NSError *error;
        NSPersistentStore *store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
        if (store == nil){
            NSLog(@"Erro ao abrir banco: %@", error);
            _coordinator = nil;
        }
    }
    return _coordinator;
}

- (NSManagedObjectContext *)contexto {
    if (_contexto == nil){
        _contexto = [[NSManagedObjectContext alloc]init];
        [_contexto setPersistentStoreCoordinator:self.coordinator];
    }
    return _contexto;
}

- (NSFetchedResultsController *)resultsController {
    if (!_resultsController){
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:TABLE];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"modelo" ascending:YES];
        [request setSortDescriptors:@[sort]];
        _resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.contexto sectionNameKeyPath:nil cacheName:nil];
        [_resultsController performFetch:nil];
    }
    return _resultsController;
}

#pragma mark - Repo methods
- (Colaborador *) insert {
    Colaborador *colaborador = [NSEntityDescription insertNewObjectForEntityForName:TABLE inManagedObjectContext:self.contexto];
    return colaborador;
}

- (BOOL) save {
    NSError *error;
    BOOL success = [self.contexto save:&error];
    if (!success){
        [self.contexto rollback];
        NSLog(@"Erro: %@", [error localizedDescription]);
    }
    return success;
}

- (void) exclude:(Colaborador *)colaborador {
    [self.contexto deleteObject:colaborador];
    [self save];
}

- (NSArray *)list{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:TABLE];
    NSArray *colaboradores = [self.contexto executeFetchRequest:request error:nil];
    return colaboradores;
}

- (Colaborador *) get{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:TABLE];
    NSError *error;
    NSArray *colaboradores = [self.contexto executeFetchRequest:request error:&error];
    NSLog(@"Erro: %@", error);
    Colaborador *colaborador;
    @try
    {
        colaborador = [colaboradores objectAtIndex:0];
    }
    @catch (NSException *ex)
    {
        
    }
    return colaborador;
}

- (BOOL) existWithGuid:(NSString *)guid {
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:TABLE];
    NSString *condicao = [NSString stringWithFormat:@"guid='%@'", guid];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:condicao];
    [request setPredicate:predicate];
    NSArray *colaboradores = [self.contexto executeFetchRequest:request error:nil];
    BOOL result = YES;
    Colaborador *colaborador = [colaboradores objectAtIndex:0];
    if (colaborador.guid == @"") {
        result = NO;
    }
    return result;
}

@end
