//
//  CardapioDiaController.m
//  cardapio
//
//  Created by Administrador on 14/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "PratoDiaController.h"
#import "PratoParser.h"
#import "Prato.h"
#import "UIImageView+WebCache.h"
#import "ColaboradorDB.h"
#import <time.h>

@interface PratoDiaController () <UIBarPositioningDelegate>

@end

@implementation PratoDiaController

#define URL @"http://consumo.fivebits.com.br/"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *) unarchivingWith {
    NSFileManager *filemgr;
    NSString *docsDir;
    NSArray *dirPaths;
    filemgr = [NSFileManager defaultManager];
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString *filePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"colaborador.archive"]];
    NSString *guid;
    if ([filemgr fileExistsAtPath:filePath])
        guid = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return guid;
}


- (void)loadCardapio{
    NSString *guid = [self unarchivingWith];
    [CardapioParser parseWithGuid:guid withCallback:^(NSDictionary *cardapioDia) {
        //NSLog(@"cardapio: %@", cardapioDia);
        if (cardapioDia == NULL) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Informação" message:@"Nenhum cardapio foi cadastrado. Retorne em alguns minutos." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            NSString *data = [cardapioDia valueForKey:@"data"];
            NSString *descricao = [cardapioDia valueForKey:@"descricao"];
            NSString *foto = [cardapioDia valueForKey:@"foto"];
            foto = [NSString stringWithFormat:@"%@%@", URL, foto];
            NSString *ingredientes = [cardapioDia valueForKey:@"ingredientes"];
            self.nbrTitulo.topItem.title = data;
            self.lblDescricao1.text = descricao;
            self.lblDescricao2.text = descricao;
            self.txtIngredientes.text = ingredientes;
            __weak PratoDiaController *this = self;
            NSURL *url = [NSURL URLWithString:foto];
            [self.imgCardapio setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                [this.imgCardapio setNeedsLayout];
                self.imgCardapio.contentMode = UIViewContentModeScaleAspectFill;
            }];
        }
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"user pressed Button Indexed 0");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        NSLog(@"user pressed Button Indexed 1");
        // Any action can be performed here
    }
}

- (void)viewDidLoad
{
    [self loadCardapio];
    [super viewDidLoad];
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
