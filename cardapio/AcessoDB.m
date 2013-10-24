//
//  AcessoDB.m
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "AcessoDB.h"
#import <CoreData/CoreData.h>

@interface AcessoDB()

@property (readonly, nonatomic, strong) NSManagedObjectModel *model;
@property (readonly, nonatomic, strong) NSPersistentStoreCoordinator *coordinator;
@property (readonly, nonatomic, strong) NSManagedObjectContext *contexto;

@end

@implementation AcessoDB

@synthesize model = _model;
@synthesize coordinator = _coordinator;
@synthesize contexto = _contexto;

static AcessoDB *instance;

+ (AcessoDB *)sharedInstance {
    if (instance == nil) instance = [[AcessoDB alloc]init];
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

- (NSPersistentStoreCoordinator *)coordinator {
    if (_coordinator == nil){
        _coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.model];
        
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Acesso.db"];
        
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
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Acesso"];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"modelo" ascending:YES];
        
        [request setSortDescriptors:@[sort]];
        
        _resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.contexto sectionNameKeyPath:nil cacheName:nil];
        
        [_resultsController performFetch:nil];
    }
    return _resultsController;
}

#pragma mark - Repo methods
- (Acesso *) addAcesso {
    Acesso *acesso = [NSEntityDescription insertNewObjectForEntityForName:@"Acesso" inManagedObjectContext:self.contexto];
    
    return acesso;
}

- (BOOL) salvar {
    NSError *error;
    BOOL success = [self.contexto save:&error];
    if (!success){
        [self.contexto rollback];
        NSLog(@"Erro: %@", [error localizedDescription]);
    }
    return success;
}

- (void) excluir:(Acesso *)acesso {
    [self.contexto deleteObject:acesso];
    [self salvar];
}

- (NSArray *)listAcessos{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Acesso"];
    NSArray *acessos = [self.contexto executeFetchRequest:request error:nil];
    return acessos;
}

- (Acesso *) getAcesso{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Acesso"];    
    NSError *error;
    NSArray *acessos = [self.contexto executeFetchRequest:request error:&error];
    NSLog(@"ERRO: %@", error);
    Acesso *acesso = [acessos objectAtIndex:0];
    return acesso;
}

- (BOOL) existAcessoWithGuid:(NSString *)guid {
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Acesso"];
    NSString *condicao = [NSString stringWithFormat:@"guid = '%@'", guid];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:condicao];
    [request setPredicate:predicate];
    NSArray *acessos = [self.contexto executeFetchRequest:request error:nil];
    BOOL result = YES;
    Acesso *acesso = [acessos objectAtIndex:0];
    if (acesso.guid == @"") {
        result = NO;
    }
    return result;
}

@end
