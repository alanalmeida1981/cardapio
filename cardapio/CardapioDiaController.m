//
//  CardapioDiaController.m
//  cardapio
//
//  Created by Administrador on 14/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "CardapioDiaController.h"
#import "CardapioParser.h"
#import "Cardapio.h"
#import "UIImageView+WebCache.h"
#import "AcessoDB.h"
#import <time.h>

@interface CardapioDiaController () <UIBarPositioningDelegate>

@end

@implementation CardapioDiaController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadCardapio{
    AcessoDB *db = [AcessoDB sharedInstance];
    Acesso *acesso = [db getAcesso];
    NSString *guid = [acesso valueForKey:@"guid"];
    [CardapioParser parseWithGuid:guid withCallback:^(NSDictionary *cardapioDia) {
        NSLog(@"cardapio: %@", cardapioDia);
        NSString *data = [cardapioDia valueForKey:@"data"];
        NSString *descricao = [cardapioDia valueForKey:@"descricao"];
        NSString *foto = [cardapioDia valueForKey:@"foto"];
        NSString *ingredientes = [cardapioDia valueForKey:@"ingredientes"];
        
        self.nbrTitulo.topItem.title = data;
        
        self.lblDescricao1.text = descricao;
        self.lblDescricao2.text = descricao;
        self.txtIngredientes.text = ingredientes;
        __weak CardapioDiaController *this = self;
        NSURL *url = [NSURL URLWithString:foto];
        [self.imgCardapio setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [this.imgCardapio setNeedsLayout];
            self.imgCardapio.contentMode = UIViewContentModeScaleAspectFill;
        }];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.loadCardapio;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sair:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

@end
