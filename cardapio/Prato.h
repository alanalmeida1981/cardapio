//
//  Prato.h
//  cardapio
//
//  Created by Alan A de Almeida on 05/11/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Avaliacao;

@interface Prato : NSManagedObject

@property (nonatomic, retain) NSNumber * codigo;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSString * foto;
@property (nonatomic, retain) NSString * ingredientes;
@property (nonatomic, retain) Avaliacao *avaliacao;

@end
