//
//  ColaboradorParser.h
//  cardapio
//
//  Created by Alan A de Almeida on 02/11/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColaboradorParser : NSObject

+ (void) addWithEmpresa:(NSString *)empresaID andNome:(NSString *)nome withCallback:(void(^)(NSDictionary *colaborador))callback;

@end
