//
//  Colaborador.h
//  cardapio
//
//  Created by Alan A de Almeida on 05/11/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Colaborador : NSManagedObject

@property (nonatomic, retain) NSString * guid;
@property (nonatomic, retain) NSString * nome;

@end
