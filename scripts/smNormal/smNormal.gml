/// @description Macanicas do objeto player

global.gravidade = 0;

function gravidadeSM(horizontal, vertical) {	
	var posicaoFinal = 0;
	var forcaGravidade = global.gravidade + 0.10;
	
	 // Colisão com chão
	if(place_meeting(horizontal, vertical + forcaGravidade, objParede)) {
		var aproximacao = sign(forcaGravidade);
		
		while(!place_meeting(horizontal, vertical + aproximacao, objParede)) {
			vertical += aproximacao;
			posicaoFinal += aproximacao;
		}
		
		global.gravidade = 0;
	} else {
		posicaoFinal = forcaGravidade;
		global.gravidade = forcaGravidade;
	}
	
	return posicaoFinal;
}