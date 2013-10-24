//
//  AvaliacaoDB.h
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Avaliacao.h"

@interface AvaliacaoDB : NSObject

@property (strong, nonatomic) NSFetchedResultsController *resultsController;

+ (AvaliacaoDB *)sharedInstance;
- (Avaliacao *)addAvaliacao;
- (BOOL)salvar;
- (void)excluir:(Avaliacao *) avaliacao;
- (NSArray *)listAvaliacao;
- (Avaliacao *)getAvaliacao;

@end
