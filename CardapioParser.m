//
//  CardapioParser.m
//  cardapio
//
//  Created by Administrador on 19/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "CardapioParser.h"

#define BASE_URL @"http://prato.fivebits.com.br/api/cardapio/dodia/"

//http://192.168.80.128/portal/api/cardapio/dodia/?guid=b91fb132-2255-460f-859b-7d67041262fa

@implementation CardapioParser

+ (void) parseWithGuid:(NSString *)guid withCallback:(void(^)(NSDictionary *cardapioDia))callback {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *params = [NSString stringWithFormat:@"?guid=%@", guid];
        NSURL *url = [NSURL URLWithString:[BASE_URL stringByAppendingString:params]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *bytes = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSDictionary *jsonCardapio;
        if (error == nil && [response statusCode] == 200) {
            jsonCardapio = [NSJSONSerialization JSONObjectWithData:bytes options:kNilOptions error:&error];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            callback(jsonCardapio);
        });
    });
}

@end
