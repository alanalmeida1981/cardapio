//
//  CardapioParser.h
//  cardapio
//
//  Created by Administrador on 19/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Prato.h"

@interface CardapioParser : NSObject

+ (void) parseWithGuid:(NSString *)guid withCallback:(void(^)(NSDictionary *cardapioDia))callback;

@end
