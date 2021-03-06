//
//  UsuarioParser.m
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "UsuarioParser.h"

#define BASE_URL @"http://consumorestful.fivebits.com.br/api/usuario/verificar/"

@implementation UsuarioParser

+ (void) parseWithName:(NSString *)name andPassword:(NSString *)password withCallback:(void(^)(NSDictionary *empresa))callback {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *params = [NSString stringWithFormat:@"?nome=%@&senha=%@", name, password];
        NSURL *url = [NSURL URLWithString:[BASE_URL stringByAppendingString:params]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *bytes = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSDictionary *jsonEmpresa;
        if (error == nil && [response statusCode] == 200) {
            jsonEmpresa = [NSJSONSerialization JSONObjectWithData:bytes options:kNilOptions error:&error];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            callback(jsonEmpresa);
        });
    });
}

@end
