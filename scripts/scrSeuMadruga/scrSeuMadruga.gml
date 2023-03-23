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
			var altaVelocidade = (global.velocidade == 2.80);
			
			var limitePulo = altaVelocidade ? -3.8 : -2.8;
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
	var botaoDireitoPress = keyboard_check(vk_right);
	var botaoEsquerdoPress = keyboard_check(vk_left);
	
	if(botaoDireitoPress && botaoEsquerdoPress && !global.parando) {
		global.parando = true;
		return;
	}
	
	var vertical = y;
	var horizontal = x;
	var velocidade = global.velocidade;
	
	ajustarVelocidade();
	
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

function ajustarVelocidade() {
	var parando = global.parando;
	var correndo = global.correndo;
	var velocidade = global.velocidade;
	
	if(parando) {
		if(velocidade > 0) {
			velocidade -= 0.05;
		} else {
			velocidade = 0;		
			parando = false;
		}
	} else {		
		var limiteVelocidade = correndo ? 2.80 : 1.5;
		
		show_debug_message("Velocidade: " + string(velocidade))
	
		if (velocidade <= limiteVelocidade) {
			velocidade += 0.05;
		} else if (velocidade > limiteVelocidade && velocidade <= 2.85) {
			velocidade -= 0.05;
		}
		
		parando = false;
	}
	
	global.parando = parando;
	global.velocidade = velocidade;
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