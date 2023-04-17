/// @description Rotinas e mecanicas do dino kiko

function rodandoInteligenciaArtificial(){
	var inteligenciaArtificialLigada = global.sistemasJogo.inteligenciaArtificial;
	
	if(inteligenciaArtificialLigada) {
		movimento();
		aplicarGravidadeGeral();
	}
}

function movimento() {		
	var forca = (direcao * 1);
	
	x += forca;
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
		serMorto();
		
		global.propriedadesPlayer.caindo = false;
		global.propriedadesPlayer.forcaGravidade = -2;
		
		aplicarGravidadePlayer(true);
	}
}