/// @description Rotinas e mecanicas do dino kiko

global.inteligenciaArtificialLigada = true;

function executarInteligenciaArtificialInimigo(){
	var inteligenciaArtificialLigada = global.inteligenciaArtificialLigada;
	
	if(inteligenciaArtificialLigada) {
		movimentoInimigo();
		aplicarGravidadeGeral();
	}
}

function movimentoInimigo() {		
	//var forca = (direcao * 1.5);
	
	x += direcao;
}

function trocarDirecaoInimigo() {
	direcao = direcao == DirecaoEnum.Direita ? DirecaoEnum.Esquerda : DirecaoEnum.Direita;

	exibirSpriteDinoKiko(SpriteEnum.Andando);
}

function morrerInimigo() {
	instance_destroy();
	
	exibirSpriteDinoKiko(SpriteEnum.Morrendo);
	
	global.propriedadesPlayer.caindo = false;
	global.propriedadesPlayer.forcaGravidade = -2;
	
	aplicarGravidadePlayer(true);
}