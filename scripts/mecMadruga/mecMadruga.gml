/// @description Mecanicas do objeto player

global.propriedadesPlayer = {
	morto: false,
	caindo: true,
	parando: true,
	velocidade: 0,
	fimJogo: false,
	samurai: false,
	correndo: false,
	abaixado: false,
	invencivel: false,
	derrapando: false,
	forcaGravidade: 0,
	forcaMovimento: 0,
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
		fimJogo: false,
		samurai: false,
		correndo: false,
		abaixado: false,
		invencivel: false,
		derrapando: false,
		forcaGravidade: 0,
		forcaMovimento: 0,
		transformando: false,
		lancandoShuriken: false,		
		instanciaHitBox: undefined,
		direcao: DirecaoEnum.Direita,
		trocarSprite: exibirSpriteMadruga
	}
}

function checarMovimento(direcao) {
	var botaoDireitoPress = keyboard_check(vk_right);
	var botaoEsquerdoPress = keyboard_check(vk_left);
	var parando = global.propriedadesPlayer.parando;
	var forcaMovimento = global.propriedadesPlayer.forcaMovimento;
	
	if(!parando && 
		(gamepadDirecaoAmbigua() ||
		(botaoDireitoPress && botaoEsquerdoPress) || 
		(direcao == DirecaoEnum.Direita && forcaMovimento < 0) || 
		(direcao == DirecaoEnum.Esquerda && forcaMovimento > 0))) 
	{
		parando = true;
		global.propriedadesPlayer.parando = true;
	}
	
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
	var parando = global.propriedadesPlayer.parando;
	
	ajustarVelocidade();	
	
	var velocidade = global.propriedadesPlayer.velocidade;	
	var forca = (direcao * velocidade);
	
	if (!colisao(TipoColisaoEnum.Horizontal, forca)) {
		x += forca;
	}
	
	global.propriedadesPlayer.direcao = direcao;
	global.propriedadesPlayer.forcaMovimento = forca;
	
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
			global.propriedadesPlayer.parando = false;
		}
	} else {		
		var limiteVelocidade = correndo ? 2.80 : 1.5;
	
		if (velocidade <= limiteVelocidade) {
			velocidade += 0.05;
		} else if (velocidade > limiteVelocidade && velocidade <= 2.85) {
			velocidade -= 0.05;
		}
	}
	 
	global.propriedadesPlayer.velocidade = velocidade;
}
	
function adicionarHitBoxInferior() {
	var morto = global.propriedadesPlayer.morto;
	var transformando = global.propriedadesPlayer.transformando;
	
	if(!morto && !transformando) { 
		var instanciaHitBox = global.propriedadesPlayer.instanciaHitBox;
		var forcaGravidade = global.propriedadesPlayer.forcaGravidade;
		
		if(forcaGravidade <> 0 && !instance_exists(instanciaHitBox)) {
			global.propriedadesPlayer.instanciaHitBox = instance_create_layer(x, y, "Secondary", objHitBoxBottom);
		} else if (forcaGravidade == 0 && instance_exists(instanciaHitBox)) {		
			instance_destroy(instanciaHitBox);
		}
	}
}
	
function aplicarGravidadePlayer(pular) {
	var morto = global.propriedadesPlayer.morto;
	var transformando = global.propriedadesPlayer.transformando;
	
	if(!morto && !transformando) {
		var caindo = global.propriedadesPlayer.caindo;
		var forcaGravidade = global.propriedadesPlayer.forcaGravidade;
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
		
		if(caindo && forcaGravidade > 0.30 && !lancandoShuriken) {
			global.propriedadesPlayer.trocarSprite(SpriteEnum.Caindo);
		}
		
		posicionarHitBoxInferior();
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

	pararTodosAudios();
	pausarAnimacoes();
	pausarAnimacoesChefe();
	instance_destroy(player);
	reiniciarPropriedadesPlayer();
	
	global.propriedadesJogo.vidas--;
	global.propriedadesPlayer.morto = true;
	global.propriedadesCamera.tremer = false;
	global.sistemasJogo.fisicaProjeteisLigado = false;
	global.sistemasJogo.inteligenciaArtificial = false;
	
	reproduzirMusica(sngMorte, false);
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
	
function colisaoMastro() {
	global.propriedadesJogo.passandoFase = true;
	var samurai = global.propriedadesPlayer.samurai;
	var limiteMastro = objBandeira1.y + objBandeira1.sprite_height + 20;
	var posicaoVerticalMastro = y >= limiteMastro ? y : limiteMastro;
	
	incluirPontos(400);
	instance_destroy();
	instance_destroy(objHitBoxTop);
	instance_destroy(objHitBoxBottom);
	reproduzirSFXPlayer(SFXEnum.Queda);
	reproduzirMusica(sngFimFase, false);
	
	objBandeira1.descer = true;
	
	with (other) {
		var posicaoHorizontalMastro = samurai ? x - 9 : x - 4
		instance_create_layer(x, y + 10, "Flags", objBandeira2);
		var madrugaPassandoFase = instance_create_layer(posicaoHorizontalMastro, posicaoVerticalMastro, "Main", objMadrugaPassandoFase);
		
		madrugaPassandoFase.alarm[0] = 200;
		
		if(samurai) {
			madrugaPassandoFase.sprite_index = sprSamuraiDescendoMastro;
		}
	}
}
	
function descerMastro() {
	if(descer) {
		y += 1.5;
		
		if(y >= 188) {
			descer = false;
		}
	}
}
	
function paralizarJogador() {	
	var fimJogo = global.propriedadesPlayer.fimJogo;
	
	if (fimJogo && place_meeting(x, y + 5, objParede)) {	
		var sprite = 0;
		var direcao = global.propriedadesPlayer.direcao;
		var samurai = global.propriedadesPlayer.samurai;
		
		if(samurai) {
			sprite = direcao == DirecaoEnum.Direita ? sprSamuraiParadoDireita : sprSamuraiParadoEsquerda;
		} else {
			sprite = direcao == DirecaoEnum.Direita ? sprMadrugaParadoDireita : sprMadrugaParadoEsquerda;
		}
		
		layer_sprite_create("Secondary_Assets", x, y, sprite);
		
		instance_destroy();
		instance_destroy(objHitBoxTop);
		instance_destroy(objHitBoxBottom);
	}
}