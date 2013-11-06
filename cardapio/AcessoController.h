//
//  AcessoController.h
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColaboradorDB.h"

@interface AcessoController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtSenha;

@property (strong, nonatomic) Colaborador *colaborador;

- (IBAction)btnEntrar:(id)sender;

@end
