//
//  UsuarioParser.h
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Acesso.h"

@interface UsuarioParser : NSObject

+ (void) parseWithName:(NSString *)nome andPassword:(NSString *)senha withCallback:(void(^)(NSDictionary *acesso))callback;

@end
