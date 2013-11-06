//
//  CardapioDiaController.h
//  cardapio
//
//  Created by Administrador on 14/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Prato.h"

@interface PratoDiaController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSair;
@property (weak, nonatomic) IBOutlet UIImageView *imgCardapio;
@property (weak, nonatomic) IBOutlet UILabel *lblDescricao1;
@property (weak, nonatomic) IBOutlet UILabel *lblDescricao2;
@property (weak, nonatomic) IBOutlet UILabel *lblIngrediente1;
@property (weak, nonatomic) IBOutlet UILabel *lblIngrediente2;
@property (weak, nonatomic) IBOutlet UITextView *txtIngredientes;
@property (weak, nonatomic) IBOutlet UINavigationBar *nbrTitulo;

@property (strong, nonatomic) Prato *prato;

- (IBAction)sair:(id)sender;

@end
