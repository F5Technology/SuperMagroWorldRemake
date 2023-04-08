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

function matarInimigo() {
	var morto = global.propriedadesPlayer.morto;
	var transformando = global.propriedadesPlayer.transformando;
	
	if(!morto && !transformando) {
		instance_destroy(); 
		incluirPontos(200);
	
		exibirSpriteDinoKiko(SpriteEnum.Morrendo);
		
		global.propriedadesPlayer.caindo = false;
		global.propriedadesPlayer.forcaGravidade = -2;
		
		aplicarGravidadePlayer(true);
	}
}
	
function pularEmCimaInimigo() {
	var limiteHit = y - (sprite_height / 2);
	var coordernadaHit = objHitBoxBottom.y + 6;
	
	if(coordernadaHit <= limiteHit) {
		matarInimigo();
	}
}