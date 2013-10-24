//
//  AvaliacaoParser.h
//  cardapio
//
//  Created by Administrador on 19/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Avaliacao.h"

@interface AvaliacaoParser : NSObject

+ (void) parseWithGuid:(NSString *)guid andCardapio:(NSString *)cardapio andLimpeza:(NSString *)limpeza andAtendimento:(NSString *)atendimento andPontualidade:(NSString *)pontualidade andComentarios:(NSString *)comentarios withCallback:(void(^)(NSDictionary *success))callback;

@end
