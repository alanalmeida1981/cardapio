//
//  AcessoController.m
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "AcessoController.h"
#import "UsuarioParser.h"
#import "ColaboradorParser.h"
#import "ColaboradorDB.h"

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
    //__weak AcessoController *this = self;
    [UsuarioParser parseWithName:nome andPassword:senha withCallback:^(NSDictionary *empresa) {
        NSLog(@"empresa: %@", empresa);
        if (empresa != nil)
        {
            NSString *empresaID = [empresa valueForKey:@"id"];
            NSString *nome = [[UIDevice currentDevice] name];
            nome = [nome stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            ColaboradorDB *db = [ColaboradorDB sharedInstance];
            self.colaborador = [db get];
            if (self.colaborador == nil){
                [ColaboradorParser addWithEmpresa:empresaID andNome:nome withCallback:^(NSDictionary *colaborador) {
                    self.colaborador = [db insert];
                    self.colaborador.guid = [colaborador valueForKey:@"guid"];
                    self.colaborador.nome = nome;
                    [db save];
                }];
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
