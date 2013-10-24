//
//  AvaliacaoParser.m
//  cardapio
//
//  Created by Administrador on 19/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "AvaliacaoParser.h"

#define BASE_URL @"http://prato.fivebits.com.br/api/avaliacao/avaliar/"

//http://192.168.80.128/portal/api/avaliacao/avaliar/?guid=f7b58436-21f4-4d13-804a-b78d3a89f4b8&cardapio=1&limpeza=2&atendimento=3&pontualidade=4&comentarios=...

@implementation AvaliacaoParser

+ (void) parseWithGuid:(NSString *)guid andCardapio:(NSString *)cardapio andLimpeza:(NSString *)limpeza andAtendimento:(NSString *)atendimento andPontualidade:(NSString *)pontualidade andComentarios:(NSString *)comentarios withCallback:(void(^)(NSDictionary *success))callback {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *params = [NSString stringWithFormat:@"?guid=%@&cardapio=%@&limpeza=%@&atendimento=%@&pontualidade=%@&comentarios=%@", guid, cardapio, limpeza, atendimento, pontualidade, comentarios];
        params = [params stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:[BASE_URL stringByAppendingString:params]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *bytes = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSDictionary *jsonSuccess;
        if (error == nil && [response statusCode] == 200) {
            jsonSuccess = [NSJSONSerialization JSONObjectWithData:bytes options:kNilOptions error:&error];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            callback(jsonSuccess);
        });
    });
}

@end
