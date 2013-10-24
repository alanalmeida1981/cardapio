//
//  AvaliacaoDB.m
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "AvaliacaoDB.h"
#import <CoreData/CoreData.h>

@interface AvaliacaoDB()

@property (readonly, nonatomic, strong) NSManagedObjectModel *model;
@property (readonly, nonatomic, strong) NSPersistentStoreCoordinator *coordinator;
@property (readonly, nonatomic, strong) NSManagedObjectContext *contexto;

@end

@implementation AvaliacaoDB

@synthesize model = _model;
@synthesize coordinator = _coordinator;
@synthesize contexto = _contexto;

static AvaliacaoDB *instance;

+ (AvaliacaoDB *)sharedInstance {
    if (instance == nil) instance = [[AvaliacaoDB alloc]init];
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
        url = [url URLByAppendingPathComponent:@"Avaliacao.db"];
        
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
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Avaliacao"];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"modelo" ascending:YES];
        
        [request setSortDescriptors:@[sort]];
        
        _resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.contexto sectionNameKeyPath:nil cacheName:nil];
        
        [_resultsController performFetch:nil];
    }
    return _resultsController;
}

#pragma mark - Repo methods
- (Avaliacao *) addAvaliacao {
    Avaliacao *avaliacao = [NSEntityDescription insertNewObjectForEntityForName:@"Avaliacao" inManagedObjectContext:self.contexto];
    
    return avaliacao;
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

- (void) excluir:(Avaliacao *)avaliacao {
    [self.contexto deleteObject:avaliacao];
    [self salvar];
}

- (NSArray *)listAvaliacao{
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Avaliacao"];
    NSArray *avaliacao = [self.contexto executeFetchRequest:request error:nil];    
    return avaliacao;
}

- (Avaliacao *)getAvaliacao {
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Avaliacao"];
    NSError *error;
    NSArray *avaliacoes = [self.contexto executeFetchRequest:request error:&error];
    NSLog(@"ERRO: %@", error);
    Avaliacao *avaliacao;
    if (avaliacoes.count > 0) {
        avaliacao = [avaliacoes objectAtIndex:0];
    }
    return avaliacao;
}

@end

