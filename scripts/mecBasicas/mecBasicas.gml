/// @description Mecanicas que objetos em geral podem ter acesso se precisar

function aplicarGravidadeGeral() {	
	var vertical = y;
	var horizontal = x;
	var forcaGravidade = forcaGravidadeAtual + 0.15;
	
	//Colisão com o chão
	if(place_meeting(horizontal, vertical + forcaGravidade, objParede)) {
		var aproximacao = sign(forcaGravidade);
			
		while(!place_meeting(horizontal, vertical + aproximacao, objParede)) {
			vertical += aproximacao;
		}
		
		forcaGravidade = 0;
	} else {
		vertical += forcaGravidade;
	}
	
	y = vertical;
	forcaGravidadeAtual = forcaGravidade;
}