/// @description Mecanicas do objeto player

global.propriedadesPlayer = {
	morto: false,
	caindo: true,
	parando: true,
	velocidade: 0,
	samurai: false,
	correndo: false,
	abaixado: false,
	derrapando: false,
	forcaGravidade: 0,
	transformando: false,
	lancandoShuriken: false,
	direcao: DirecaoEnum.Direita,
	trocarSprite: exibirSpriteMadruga
}
	
function checarMovimento(direcao) {
	var parando = global.propriedadesPlayer.parando;
	
	if(parando) {
		var forcaGravidade = global.propriedadesPlayer.forcaGravidade;
		
		global.propriedadesPlayer.derrapando = true;
		
		if(forcaGravidade == 0) {
			global.propriedadesPlayer.trocarSprite(SpriteEnum.Derrapando);
		}
	} else {
		global.propriedadesPlayer.derrapando = false;
		movimentar(direcao);
	}
}

function movimentar(direcao) {		
	var botaoDireitoPress = keyboard_check(vk_right);
	var botaoEsquerdoPress = keyboard_check(vk_left);
	
	if(botaoDireitoPress && botaoEsquerdoPress && !global.propriedadesPlayer.parando) {
		global.propriedadesPlayer.parando = true;
		return;
	}
	
	ajustarVelocidade();
	
	var vertical = y;
	var horizontal = x;
	var velocidade = global.propriedadesPlayer.velocidade;
	
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
	global.propriedadesPlayer.direcao = direcao;
	
	checarSpriteMovimento();
}

function ajustarVelocidade() {
	var parando = global.propriedadesPlayer.parando;
	var correndo = global.propriedadesPlayer.correndo;
	var velocidade = global.propriedadesPlayer.velocidade;
	
	if(parando) {
		if(velocidade > 0) {
			var reducao = velocidade > 1.5 ? 0.20 : 0.05;
			
			velocidade -= reducao;
		} else {
			velocidade = 0;		
			parando = false;
		}
	} else {		
		var limiteVelocidade = correndo ? 2.80 : 1.5;
	
		if (velocidade <= limiteVelocidade) {
			velocidade += 0.05;
		} else if (velocidade > limiteVelocidade && velocidade <= 2.85) {
			velocidade -= 0.05;
		}
	}
	
	global.propriedadesPlayer.parando = parando;
	global.propriedadesPlayer.velocidade = velocidade;
}
	
function aplicarGravidadePlayer(pular) {
	var vertical = y;
	var horizontal = x;
	var caindo = global.propriedadesPlayer.caindo;
	var forcaGravidade = global.propriedadesPlayer.forcaGravidade;
	var lancandoShuriken = global.propriedadesPlayer.lancandoShuriken;
	
	if (pular) {
		if(!caindo) {
			var altaVelocidade = (global.propriedadesPlayer.velocidade == 2.80);
			
			var limitePulo = altaVelocidade ? -3.8 : -2.8;
			forcaGravidade += -0.40;
			
			if(forcaGravidade <= limitePulo) {
				caindo = true;
				global.propriedadesPlayer.caindo = true;
			} else if (!lancandoShuriken) {
				global.propriedadesPlayer.trocarSprite(SpriteEnum.Pulando);
			}
		} else {
			// Retorno impede com que o botão de pulo acelere a velocidade da queda
			return;
		}
	} else {
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
		global.propriedadesPlayer.forcaGravidade = forcaGravidade;
		
		if(!caindo) {
			caindo = (forcaGravidade > 0);
			global.propriedadesPlayer.caindo = caindo;
		}
	}
	
	if(caindo && !lancandoShuriken && forcaGravidade > 0.30) {
		global.propriedadesPlayer.trocarSprite(SpriteEnum.Caindo);
	}
	
	y = vertical;
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
			
			global.propriedadesPlayer.forcaGravidade = 0;
			
			if(colisaoTeto) {
				global.propriedadesPlayer.caindo = true;
			} else {
				global.propriedadesPlayer.caindo = false;
				
				checarSpriteImovel();
			}
			break;
		
		case TipoColisaoEnum.Horizontal:
			posicao = horizontal;
			
			while(!place_meeting(posicao + aproximacao, vertical, objParede)) {
				posicao += aproximacao;
			}
			
			global.propriedadesPlayer.velocidade = 0;		
			global.propriedadesPlayer.parando = false;
			break;
	}
	
	return posicao;
}

function checarSpriteImovel() {
	var abaixado = global.propriedadesPlayer.abaixado;
	var velocidade = global.propriedadesPlayer.velocidade;
	var lancandoShuriken = global.propriedadesPlayer.lancandoShuriken;
	
	 if (velocidade == 0 && !lancandoShuriken) {
		 var sprite = abaixado ? SpriteEnum.Abaixado : SpriteEnum.Parado;	
	
		global.propriedadesPlayer.trocarSprite(sprite);
	 }
}
	
function checarSpriteMovimento() {	
	var lancandoShuriken = global.propriedadesPlayer.lancandoShuriken;
	var forcaGravidade = global.propriedadesPlayer.forcaGravidade;
	
	if (forcaGravidade == 0 && !lancandoShuriken) {
		var derrapando = global.propriedadesPlayer.derrapando;
		var velocidade = global.propriedadesPlayer.velocidade;
		
		if (!derrapando && velocidade > 0) {
			var sprite = 0;
			var limiteVelocidade = 2.70;
			
			if(velocidade <= limiteVelocidade) {
				sprite = SpriteEnum.Andando;
			} else {
				sprite = SpriteEnum.Correndo;
			}
			
			global.propriedadesPlayer.trocarSprite(sprite);
		}
	}
}
	
function morrer() {	
	instance_destroy();
	global.propriedadesPlayer.morto = true;
	
	layer_sequence_create("Animations", x, y, anMadrugaMorrendo);
	instance_create_layer(x, y, "Instances", objSeuMadrugaMorrendo);
}
	
function reiniciarPropriedadesPlayer() {
	global.propriedadesPlayer = {
		morto: false,
		caindo: true,
		parando: true,
		velocidade: 0,
		samurai: false,
		correndo: false,
		abaixado: false,
		derrapando: false,
		forcaGravidade: 0,
		transformando: false,
		lancandoShuriken: false,
		direcao: DirecaoEnum.Direita,
		trocarSprite: exibirSpriteMadruga
	}
}
	
function tomarDano() {	
	var samurai = global.propriedadesPlayer.samurai;
	
	if (samurai) {
		transformarNormal();
		global.propriedadesPlayer.correndo = false;
		global.propriedadesPlayer.abaixado = false;
		global.propriedadesPlayer.lancandoShuriken = false;
	} else {
		morrer();
	}
}