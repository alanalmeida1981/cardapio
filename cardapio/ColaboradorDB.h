//
//  AcessoDB.h
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Colaborador.h"

@interface ColaboradorDB : NSObject

@property (strong, nonatomic) NSFetchedResultsController *resultsController;

+ (ColaboradorDB *) sharedInstance;
- (Colaborador *) insert;
- (BOOL) save;
- (void) exclude:(Colaborador *) colaborador;
- (NSArray *) list;
- (Colaborador *) get;
- (BOOL) existWithGuid:(NSString *)guid;

@end