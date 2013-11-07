//
//  AvaliacaoController.h
//  cardapio
//
//  Created by Administrador on 14/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvaliacaoDB.h"
#import "TQStarRatingView.h"

@interface AvaliacaoController : UIViewController<StarRatingViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblNotaComida;
@property (nonatomic,strong)TQStarRatingView *ratingComida;

@property (weak, nonatomic) IBOutlet UILabel *lblNotaLimpeza;
@property (nonatomic,strong)TQStarRatingView *ratingLimpeza;

@property (weak, nonatomic) IBOutlet UILabel *lblNotaAtendimento;
@property (nonatomic,strong)TQStarRatingView *ratingAtendimento;

@property (weak, nonatomic) IBOutlet UILabel *lblNotaPontualidade;
@property (nonatomic,strong)TQStarRatingView *ratingPontualidade;

@property (weak, nonatomic) IBOutlet UITextView *txtComentarios;

@property (strong, nonatomic) Avaliacao *avaliacao;

- (IBAction)sair:(id)sender;
- (IBAction)confirmar:(id)sender;


@end
