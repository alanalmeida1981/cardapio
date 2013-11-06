//
//  ColaboradorParser.m
//  cardapio
//
//  Created by Alan A de Almeida on 02/11/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "ColaboradorParser.h"

@implementation ColaboradorParser

#define BASE_URL @"http://consumorestful.fivebits.com.br/api/colaborador/adicionar/"

+ (void)addWithEmpresa:(NSString *)empresaID andNome:(NSString *)nome withCallback:(void (^)(NSDictionary *))callback{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *params = [NSString stringWithFormat:@"?empresaid=%@&nome=%@", empresaID, nome];
        NSURL *url = [NSURL URLWithString:[BASE_URL stringByAppendingString:params]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *bytes = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSDictionary *jsonColaborador;
        if (error == nil && [response statusCode] == 200) {
            jsonColaborador = [NSJSONSerialization JSONObjectWithData:bytes options:kNilOptions error:&error];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            callback(jsonColaborador);
        });
    });
}

@end
