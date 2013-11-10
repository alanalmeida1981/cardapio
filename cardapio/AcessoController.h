//
//  AcessoController.h
//  cardapio
//
//  Created by Administrador on 18/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColaboradorDB.h"

@interface AcessoController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) Colaborador *colaborador;

@property (weak, nonatomic) IBOutlet UITextField *txtNome;
@property (weak, nonatomic) IBOutlet UITextField *txtSenha;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) NSString *filePath;

- (IBAction)btnEntrar:(id)sender;

@end
