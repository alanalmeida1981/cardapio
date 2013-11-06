//
//  UsuarioParser.h
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Empresa.h"

@interface UsuarioParser : NSObject

+ (void) parseWithName:(NSString *)name andPassword:(NSString *)password withCallback:(void(^)(NSDictionary *empresa))callback;

@end
