//
//  Acesso.h
//  cardapio
//
//  Created by Administrador on 19/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Acesso : NSManagedObject

@property (nonatomic, retain) NSString * guid;
@property (nonatomic, retain) NSString * nome;

@end
