/// @description Mecanicas do objeto player

global.caindo = true;
global.forcaGravidade = 0;

function gravidade(horizontal, vertical, pular) {
	var caindo = global.caindo;
	var posicaoVertical = vertical;
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
			//retorno impede com que o botão de pulo acelere a velocidade da queda
			return vertical;
		}
	} else if (!pular) {
		forcaGravidade += 0.15;
	}
	
	// Colisão com chão e teto
	if(place_meeting(horizontal, posicaoVertical + forcaGravidade, objParede)) {
		var aproximacao = sign(forcaGravidade);
		var colisaoTeto = (posicaoVertical + forcaGravidade < 0);
		
		while(!place_meeting(horizontal, posicaoVertical + aproximacao, objParede)) {
			posicaoVertical += aproximacao;
		}
		
		global.forcaGravidade = 0;
		global.caindo = colisaoTeto;
	} else {
		posicaoVertical += forcaGravidade;
		global.forcaGravidade = forcaGravidade;
		
		if(!caindo) {
			global.caindo = (forcaGravidade > 0);
		}
	}
	
	return posicaoVertical;
}
	
function movimentar(horizontal, vertical, direcao) {
	var posicaoHorizontal = horizontal + (direcao * 1);
	
	show_debug_message(string(direcao));
	
	return posicaoHorizontal;
}