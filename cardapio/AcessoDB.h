//
//  AcessoDB.h
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Acesso.h"

@interface AcessoDB : NSObject

@property (strong, nonatomic) NSFetchedResultsController *resultsController;

+ (AcessoDB *)sharedInstance;
- (Acesso *)addAcesso;
- (BOOL)salvar;
- (void)excluir:(Acesso *) acesso;
- (NSArray *) listAcessos;
- (Acesso *) getAcesso;
- (BOOL) existAcessoWithGuid:(NSString *)guid;

@end