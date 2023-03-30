/// @description Sistema de controle de dados do jogo (HUD)

global.sistemaTempoAtivo = true;

global.propriedadesJogo = {
	fase: 1,
	mundo: 1,
	vidas: 2,
	tempo: 51,
	pontos: 0,
	moedas: 0
}

function reiniciarPropriedadesJogo() {
	global.propriedadesJogo.fase = 1;
	global.propriedadesJogo.mundo = 1;
	global.propriedadesJogo.vidas = 2;
	global.propriedadesJogo.tempo = 51;
	global.propriedadesJogo.pontos = 0;
	global.propriedadesJogo.moedas = 0;
}

function coletarMoeda() {
	var moedas = global.propriedadesJogo.moedas;
	
	if (moedas >= 100) {
		moedas = 0;
		global.propriedadesJogo.vidas++;
	} else {
		moedas++;
	}
	
	global.propriedadesJogo.pontos += 10;
	global.propriedadesJogo.moedas = moedas;
}

function checarTempo() {	
	var morto = global.propriedadesPlayer.morto;
	var transformando = global.propriedadesPlayer.transformando;
	
	if(!morto && !transformando) {
		var tempo = global.propriedadesJogo.tempo;
	
		tempo--;
		global.propriedadesJogo.tempo = tempo;
		
		show_debug_message("tempo: " + string(global.propriedadesJogo.tempo));
		
		
		if (tempo <= 0) {
			morrer();
		} else {
			var segundos = 3;
			
			alarm[0] = 60 * 3;
		}
	} else {
		var segundos = 3;
		
		alarm[0] = 60 * 3;
	}
}