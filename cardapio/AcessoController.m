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

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void) keyboardDidShow:(NSNotification *) notification {
    [self.scrollView setFrame:CGRectMake(0, -190, 320, 800)];
}

- (void) keyboardDidHide:(NSNotification *) notification {
    [self.scrollView setFrame:CGRectMake(0, 0, 320, 560)];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{    
    NSLog(@"%@",textField.text);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name: UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidHide:) name: UIKeyboardDidHideNotification object:nil];
    
    self.txtNome.delegate = self;
    self.txtSenha.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnEntrar:(id)sender {
    [self.scrollView setFrame:CGRectMake(0, 0, 320, 560)];
    
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
