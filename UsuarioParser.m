//
//  UsuarioParser.m
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "UsuarioParser.h"

#define BASE_URL @"http://prato.fivebits.com.br/api/usuario/verificar/"

//http://192.168.213.129/portal/api/usuario/verificarusuario/?nome=admin&senha=a

@implementation UsuarioParser

+ (void) parseWithName:(NSString *)nome andPassword:(NSString *)senha withCallback:(void(^)(NSDictionary *acesso))callback {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *params = [NSString stringWithFormat:@"?nome=%@&senha=%@", nome, senha];
        NSURL *url = [NSURL URLWithString:[BASE_URL stringByAppendingString:params]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *bytes = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSDictionary *jsonAcesso;
        if (error == nil && [response statusCode] == 200) {
            jsonAcesso = [NSJSONSerialization JSONObjectWithData:bytes options:kNilOptions error:&error];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            callback(jsonAcesso);
        });
    });
}

@end
