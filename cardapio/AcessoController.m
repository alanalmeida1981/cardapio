//
//  AcessoController.m
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "AcessoController.h"
#import "UsuarioParser.h"
#import "AcessoDB.h"

@interface AcessoController ()

@end

@implementation AcessoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnEntrar:(id)sender {
    NSString *nome = self.txtNome.text;
    NSString *senha = self.txtSenha.text;
    __weak AcessoController *this = self;
    [UsuarioParser parseWithName:nome andPassword:senha withCallback:^(NSDictionary *acesso) {
        NSLog(@"usuario: %@", acesso);
        if (acesso != nil)
        {
            AcessoDB *db = [AcessoDB sharedInstance];
            if (self.acesso == nil){
                self.acesso = [db addAcesso];
            }
            self.acesso.guid = [acesso valueForKey:@"guid"];
            BOOL existe = [db existAcessoWithGuid:self.acesso.guid];
            if (!existe) {
                self.acesso.nome = [acesso valueForKey:@"nome"];
                [db salvar];
            }
            [self performSegueWithIdentifier:@"acesso" sender:self];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Nome e/ou senha não existe." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

@end
