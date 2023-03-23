/// @description Mecanicas do objeto player

global.direcao = 0;
global.caindo = true;
global.parando = true;
global.velocidade = 0;
global.correndo = false;
global.forcaGravidade = 0;

function aplicarGravidade(pular) {
	var vertical = y;
	var horizontal = x;
	var caindo = global.caindo;
	var forcaGravidade = global.forcaGravidade;
	
	if (pular) {
		if(!caindo) {
			var limitePulo = -2.8;
			forcaGravidade += -0.40;
			
			if(forcaGravidade <= limitePulo) {
				caindo = true;
				global.caindo = true;
			}
		} else {
			// Retorno impede com que o botão de pulo acelere a velocidade da queda
			return;
		}
	} else if (!pular) {
		forcaGravidade += 0.15;
	}
	
	// Colisão com chão e teto
	if(place_meeting(horizontal, vertical + forcaGravidade, objParede)) {
		vertical = realizarColisaoParede(
			TipoColisaoEnum.Vertical, 
			forcaGravidade, 
			horizontal, 
			vertical
		);
	} else {
		vertical += forcaGravidade;
		global.forcaGravidade = forcaGravidade;
		
		if(!caindo) {
			global.caindo = (forcaGravidade > 0);
		}
	}
	
	y = vertical;
}

function movimentar(direcao) {		
	var vertical = y;
	var horizontal = x;
	var velocidade = global.velocidade;
	var botaoDireitoPress = keyboard_check(ord("D"));
	var botaoEsquerdoPress = keyboard_check(ord("A"));
	
	if(botaoDireitoPress && botaoEsquerdoPress && !global.parando) {
		global.parando = true;
		return;
	}
	
	if(global.parando) {
		diminuirVelocidade();
	} else {		
		aumentarVelocidade();
		global.parando = false;
	}
	
	var forca = (direcao * velocidade);
	
	// Colisão com paredes
	if(place_meeting(horizontal + forca, vertical, objParede)) {
		horizontal = realizarColisaoParede(
			TipoColisaoEnum.Horizontal, 
			forca, 
			horizontal, 
			vertical
		);
	} else {
		horizontal += forca;
	}
	
	
	x = horizontal;
	global.direcao = direcao;
}
	
function aumentarVelocidade() {
	var limiteVelocidade = 1.5;
	
	if (global.velocidade <= limiteVelocidade) {
		global.velocidade += 0.05;
	}
}

function diminuirVelocidade() {
	if(global.velocidade > 0) {
		global.velocidade -= 0.05;
	} else {
		global.velocidade = 0;		
		global.parando = false;
	}
}
		
function realizarColisaoParede(tipo, forca, horizontal, vertical) {
	var posicao = 0;	
	var aproximacao = sign(forca);
	
	switch(tipo) {
		case TipoColisaoEnum.Vertical:
			posicao = vertical;
			var colisaoTeto = (posicao + forca < 0);
			
			while(!place_meeting(horizontal, posicao + aproximacao, objParede)) {
				posicao += aproximacao;
			}
			
			global.forcaGravidade = 0;
			global.caindo = colisaoTeto;
			break;
		
		case TipoColisaoEnum.Horizontal:
			posicao = horizontal;
			
			while(!place_meeting(posicao + aproximacao, vertical, objParede)) {
				posicao += aproximacao;
			}
			
			global.velocidade = 0;		
			global.parando = false;
			break;
	}
	
	return posicao;
}