/// @description Rotinas e mecanicas do dino kiko

function rodandoInteligenciaArtificial(){
	var inteligenciaArtificialLigada = global.sistemasJogo.inteligenciaArtificial;
	
	if(inteligenciaArtificialLigada) {
		movimento();
		aplicarGravidadeGeral();
		
		if(andandoTijolos && noChao) {
			checagemMortePorTijolos()
		}
	}
}

function movimento() {			
	x += direcao;
	
	if(andandoTijolos && noChao) {
		var limiteVertical = y + 8;
		var limiteHorizontal = x + (sprite_width / 2 * direcao) + 5;
		
		if(!place_meeting(limiteHorizontal, limiteVertical, objTijolos)) {
			trocarDirecao();
		}
	}
}

function trocarDirecao() {	
	if(direcao == DirecaoEnum.Direita) {
		direcao = DirecaoEnum.Esquerda;
	} else {
		direcao = DirecaoEnum.Direita;
	}

	exibirSpriteDinoKiko(SpriteEnum.Andando);
}

function serMorto() {
	var playerMorto = global.propriedadesPlayer.morto;
	var playerTransformando = global.propriedadesPlayer.transformando;
	
	if(!playerMorto && !playerTransformando) {
		instance_destroy(); 
		incluirPontos(200);
	
		exibirSpriteDinoKiko(SpriteEnum.Morrendo);
	}
}
	
function aplicandoDanoPulo() {
	var limiteHit = y - (sprite_height / 2);
	var coordernadaHit = objHitBoxBottom.y + 6;
	
	if(coordernadaHit <= limiteHit) {
		var samurai = global.propriedadesPlayer.samurai;
		var player = samurai ? objSamurai : objSeuMadruga;
		
		serMorto();
		
		global.propriedadesPlayer.caindo = false;
		global.propriedadesPlayer.forcaGravidade = -2;
		
		aplicarGravidadePlayer(true);
	}
}
	
function checagemMortePorTijolos() {
	var limiteVertical = y + 8;
	
	if(!place_meeting(x, limiteVertical, objTijolos)) {
		serMorto();
	}
}