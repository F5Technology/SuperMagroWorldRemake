/// @description Mecanicas que objetos em geral podem ter acesso se precisar

function aplicarGravidadeGeral() {	
	var vertical = y;
	var horizontal = x;
	var limitePulo = -3;
	var forcaGravidade = forcaGravidadeAtual + 0.15;
	
	//Colisão com o chão
	if(place_meeting(horizontal, vertical + forcaGravidade, objParede)) {
		var aproximacao = sign(forcaGravidade);
			
		while(!place_meeting(horizontal, vertical + aproximacao, objParede)) {
			vertical += aproximacao;
		}
		
		forcaGravidade = 0;
	} else if(place_meeting(horizontal, vertical + forcaGravidade, objInterrogacao)) { //Colisão com o bloco de interrogação
		var aproximacao = sign(forcaGravidade);
			
		while(!place_meeting(horizontal, vertical + aproximacao, objInterrogacao)) {
			vertical += aproximacao;
		}
		
		forcaGravidade = 0;
	} else if(place_meeting(horizontal, vertical + forcaGravidade, objTijolos)) { //Colisão com o bloco de tijolos
		var aproximacao = sign(forcaGravidade);
			
		while(!place_meeting(horizontal, vertical + aproximacao, objTijolos)) {
			vertical += aproximacao;
		}
		
		forcaGravidade = 0;
		
		if(andandoTijolos) {
			noChao = true;
		}
	} else {
		vertical += forcaGravidade;
	}
	
	y = vertical;
	forcaGravidadeAtual = forcaGravidade;
}
	
function moverParaCentroSala() {
	if(derrubado) {	
		var centroSala = room_width / 2;
		var valorHorizontalArredondado = round(x);
		
		if(valorHorizontalArredondado < centroSala) {
			x += 1;
		} else if (valorHorizontalArredondado > centroSala) {
			x -= 1;
		} else {
			derrubado = false;
		}
	}
}