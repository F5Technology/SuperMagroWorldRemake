/// @description Mecanicas do objeto player

global.propriedadesPlayer = {
	morto: false,
	caindo: true,
	parando: true,
	velocidade: 0,
	samurai: false,
	correndo: false,
	abaixado: false,
	invencivel: false,
	derrapando: false,
	forcaGravidade: 0,
	transformando: false,
	lancandoShuriken: false,
	instanciaHitBox: undefined,
	direcao: DirecaoEnum.Direita,
	trocarSprite: exibirSpriteMadruga
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
		invencivel: false,
		derrapando: false,
		forcaGravidade: 0,
		transformando: false,
		lancandoShuriken: false,		
		instanciaHitBox: undefined,
		direcao: DirecaoEnum.Direita,
		trocarSprite: exibirSpriteMadruga
	}
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
	
	var velocidade = global.propriedadesPlayer.velocidade;	
	var forca = (direcao * velocidade);
	
	if (!colisao(TipoColisaoEnum.Horizontal, forca)) {
		x += forca;
	}
	
	global.propriedadesPlayer.direcao = direcao;
	
	exibirSpriteMovimento();
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
	var morto = global.propriedadesPlayer.morto;
	var transformando = global.propriedadesPlayer.transformando;
	
	if(!morto && !transformando) {
		var caindo = global.propriedadesPlayer.caindo;
		var forcaGravidade = global.propriedadesPlayer.forcaGravidade;
		var instanciaHitBox = global.propriedadesPlayer.instanciaHitBox;
		var lancandoShuriken = global.propriedadesPlayer.lancandoShuriken;
		
		if (pular) {
			if(!caindo) {
				var limitePulo = -3;
				var velocidade = global.propriedadesPlayer.velocidade;
				var acimaVelocidade = (velocidade > 1.5);
				
				if (velocidade > 1.5) {
					limitePulo -= (velocidade - 1.80);
				}
				
				forcaGravidade += -0.40;
				
				if(forcaGravidade <= limitePulo) {
					caindo = true;
					global.propriedadesPlayer.caindo = true;
				} else if (!lancandoShuriken) {
					global.propriedadesPlayer.trocarSprite(SpriteEnum.Pulando);
				}
				
				if(!instance_exists(instanciaHitBox)) {
					global.propriedadesPlayer.instanciaHitBox = instance_create_layer(x, y, "Secondary", objHitBoxBottom);
				}
			} else {
				// Retorno impede com que o botão de pulo acelere a velocidade da queda
				return;
			}
		} else {
			forcaGravidade += 0.15;
		}
		
		if (!colisao(TipoColisaoEnum.Vertical, forcaGravidade)) {
			y += forcaGravidade;
			global.propriedadesPlayer.forcaGravidade = forcaGravidade;
			
			if(!caindo) {
				caindo = (forcaGravidade > 0);
				global.propriedadesPlayer.caindo = caindo;
			}
		}
		
		if(caindo && forcaGravidade > 0.30) {	
			if(!instance_exists(instanciaHitBox)) {
				global.propriedadesPlayer.instanciaHitBox = instance_create_layer(x, y, "Secondary", objHitBoxBottom);
			}
			
			if(!lancandoShuriken) {
				global.propriedadesPlayer.trocarSprite(SpriteEnum.Caindo);
			}
		} else if (forcaGravidade < 0.30 && forcaGravidade > -0.40 && instance_exists(instanciaHitBox)) {		
			instance_destroy(instanciaHitBox);
		}
	}
}

function exibirSpriteImovel() {
	var abaixado = global.propriedadesPlayer.abaixado;
	var velocidade = global.propriedadesPlayer.velocidade;
	var lancandoShuriken = global.propriedadesPlayer.lancandoShuriken;
	
	 if (velocidade == 0 && !lancandoShuriken) {
		 var sprite = abaixado ? SpriteEnum.Abaixado : SpriteEnum.Parado;	
	
		global.propriedadesPlayer.trocarSprite(sprite);
	 }
}
	
function exibirSpriteMovimento() {	
	var caindo = global.propriedadesPlayer.caindo;
	var forcaGravidade = global.propriedadesPlayer.forcaGravidade;
	var lancandoShuriken = global.propriedadesPlayer.lancandoShuriken;
	
	if (forcaGravidade == 0 && !caindo && !lancandoShuriken) {
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
	var samurai = global.propriedadesPlayer.samurai;
	var player = samurai ? objSamurai : objSeuMadruga;
	
	var vertical = player.y;
	var horizontal = player.x;	
	
	var animacoes = layer_get_all_elements("Animations_Boss");

	audio_stop_all();
	instance_destroy(player);	
	global.sistemasJogo.inteligenciaArtificial = false;
	global.propriedadesJogo.vidas--;
	global.propriedadesPlayer.morto = true;
	global.propriedadesCamera.tremer = false;
	
    for (var i = 0; i < array_length(animacoes); i++;)
    {       
		layer_sequence_pause(animacoes[i]);
    }
	
	layer_sequence_create("Animations", horizontal, vertical, anMadrugaMorrendo);
	instance_create_layer(horizontal, vertical, "Main", objSeuMadrugaMorrendo);
}
	
function tomarDano() {	
	var samurai = global.propriedadesPlayer.samurai;
	var invencivel = global.propriedadesPlayer.invencivel;
	
	if(!invencivel) {
		if (samurai) {
			transformarNormal();
			global.propriedadesPlayer.correndo = false;
			global.propriedadesPlayer.abaixado = false;
			global.propriedadesPlayer.lancandoShuriken = false;
		} else {		
			morrer();
		}
	}
}

function aplicarInvencibilidade() {
	var invencivel = global.propriedadesPlayer.invencivel;
	
	if(invencivel) {
		piscarSprite();
		
		alarm[0] = 5;
	}
}

function finalizarInvencibilidade() {
	global.propriedadesPlayer.invencivel = false;
	
	image_alpha = 1;
}