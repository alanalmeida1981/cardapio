//
//  CardapioDiaController.h
//  cardapio
//
//  Created by Administrador on 14/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cardapio.h"

@interface CardapioDiaController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSair;
@property (weak, nonatomic) IBOutlet UIImageView *imgCardapio;
@property (weak, nonatomic) IBOutlet UILabel *lblDescricao1;
@property (weak, nonatomic) IBOutlet UILabel *lblDescricao2;
@property (weak, nonatomic) IBOutlet UILabel *lblIngrediente1;
@property (weak, nonatomic) IBOutlet UILabel *lblIngrediente2;
@property (weak, nonatomic) IBOutlet UITextView *txtIngredientes;
@property (weak, nonatomic) IBOutlet UINavigationBar *nbrTitulo;

@property (strong, nonatomic) Cardapio *cardapio;

- (IBAction)sair:(id)sender;

@end
