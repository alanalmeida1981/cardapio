//
//  Avaliacao.h
//  cardapio
//
//  Created by Administrador on 19/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Avaliacao : NSManagedObject

@property (nonatomic, retain) NSNumber * atendimento;
@property (nonatomic, retain) NSNumber * cardapio;
@property (nonatomic, retain) NSString * comentarios;
@property (nonatomic, retain) NSNumber * limpeza;
@property (nonatomic, retain) NSNumber * pontualidade;

@end
