//
//  Cardapio.h
//  cardapio
//
//  Created by Administrador on 19/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Avaliacao;

@interface Cardapio : NSManagedObject

@property (nonatomic, retain) NSNumber * codigo;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSString * foto;
@property (nonatomic, retain) NSString * ingredientes;
@property (nonatomic, retain) Avaliacao *avaliacao;

@end
