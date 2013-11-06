//
//  AvaliacaoController.m
//  cardapio
//
//  Created by Administrador on 14/10/13.
//  Copyright (c) 2013 fivebits. All rights reserved.
//

#import "AvaliacaoController.h"
#import "AvaliacaoDB.h"
#import "AvaliacaoParser.h"
#import "ColaboradorDB.h"

@interface AvaliacaoController ()

@end

@implementation AvaliacaoController

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
    _ratingComida = [[TQStarRatingView alloc] initWithFrame:CGRectMake(23, 86, 280, 48) numberOfStar:5];
    _ratingComida.delegate = self;
    _ratingComida.tag = 1;
    _ratingLimpeza = [[TQStarRatingView alloc] initWithFrame:CGRectMake(23, 157, 280, 48) numberOfStar:5];
    _ratingLimpeza.delegate = self;
    _ratingLimpeza.tag = 2;
    _ratingAtendimento = [[TQStarRatingView alloc] initWithFrame:CGRectMake(23, 228, 280, 48) numberOfStar:5];
    _ratingAtendimento.delegate = self;
    _ratingAtendimento.tag = 3;
    _ratingPontualidade = [[TQStarRatingView alloc] initWithFrame:CGRectMake(23, 299, 280, 48) numberOfStar:5];
    _ratingPontualidade.delegate = self;
    _ratingPontualidade.tag = 4;
    AvaliacaoDB *db = [AvaliacaoDB sharedInstance];
    Avaliacao *avaliacao = [db getAvaliacao];
    if (avaliacao != nil) {
        [_ratingComida setScore:[avaliacao.comida floatValue] withAnimation:YES];
        [_ratingLimpeza setScore:[avaliacao.limpeza floatValue] withAnimation:YES];
        [_ratingAtendimento setScore:[avaliacao.atendimento floatValue] withAnimation:YES];
        [_ratingPontualidade setScore:[avaliacao.pontualidade floatValue] withAnimation:YES];
        NSLog(@"avaliacao: %@", avaliacao);
    }
    [self.view addSubview:_ratingComida];
    [self.view addSubview:_ratingLimpeza];
    [self.view addSubview:_ratingAtendimento];
    [self.view addSubview:_ratingPontualidade];
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    NSString *nota = [NSString stringWithFormat:@"%0.1f", score * 10];
    if (view.tag == 1) {
        self.lblNotaComida.text = [NSString stringWithFormat:@"%@", nota];
    } else if (view.tag == 2) {
        self.lblNotaLimpeza.text = [NSString stringWithFormat:@"%@", nota];
    } else if (view.tag == 3) {
        self.lblNotaAtendimento.text = [NSString stringWithFormat:@"%@", nota];
    } else if (view.tag == 4) {
        self.lblNotaPontualidade.text = [NSString stringWithFormat:@"%@", nota];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sair:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirmar:(id)sender {
    AvaliacaoDB *db = [AvaliacaoDB sharedInstance];
    if (self.avaliacao == nil){
        self.avaliacao = [db addAvaliacao];
    }
    self.avaliacao.comida = @([self.lblNotaComida.text floatValue]);
    self.avaliacao.limpeza = @([self.lblNotaLimpeza.text floatValue]);
    self.avaliacao.atendimento = @([self.lblNotaAtendimento.text floatValue]);
    self.avaliacao.pontualidade = @([self.lblNotaPontualidade.text floatValue]);
    self.avaliacao.comentarios = self.txtComentarios.text;
    NSLog(@"avaliacao: %@", self.avaliacao);
    
     ColaboradorDB *db2 = [ColaboradorDB sharedInstance];
     Colaborador *colaborador = [db2 get];
     NSString *guid = [colaborador valueForKey:@"guid"];
     
    [AvaliacaoParser parseWithGuid:guid andCardapio:self.lblNotaComida.text andLimpeza:self.lblNotaLimpeza.text andAtendimento:self.lblNotaAtendimento.text andPontualidade:self.lblNotaPontualidade.text andComentarios:self.avaliacao.comentarios withCallback:^(NSDictionary *success) {
        if (success != nil)
        {
            [self.tabBarController setSelectedIndex:0];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Informação" message:@"Obrigado. Sua avaliação foi enviada com sucesso." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ops!" message:@"Erro ao enviar a avaliação." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    /*
    if ([db salvar]){
        [self.tabBarController setSelectedIndex:0];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Informacao" message:@"Avaliacao enviada com sucesso." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        self.avaliacao = nil;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ops!" message:@"Erro ao salvar a avaliacao." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }*/
}

@end
