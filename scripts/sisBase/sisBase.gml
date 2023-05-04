/// @description Sistema basicos de controle de dados do jogo

global.sistemasJogo = {
	tempo: false,
	inteligenciaArtificial: true,
	fisicaProjeteisLigado: true
}

global.propriedadesJogo = {
	fase: 1,
	mundo: 1,
	vidas: 2,
	tempo: 51,
	pontos: 0,
	moedas: 0,
	pause: false
}

function reiniciarPropriedadesJogo() {
	global.propriedadesJogo = {
		fase: 1,
		mundo: 1,
		vidas: 2,
		tempo: 51,
		pontos: 0,
		moedas: 0,
		pause: false
	}
}

function registrarMoeda() {
	var moedas = global.propriedadesJogo.moedas;
	
	if (moedas >= 50) {
		moedas = 0;
		global.propriedadesJogo.vidas++;
		
		mostrarValorEmJogo(ValorEnum.Vida);
	} else {
		moedas++;
	
		incluirPontos(10);
		reproduzirSFXElementos(SFXEnum.Moeda);
	}
	
	global.propriedadesJogo.moedas = moedas;
}

function coletarMoeda() {
	instance_destroy();
	instance_create_layer(x, y, "Secondary", objBrilho);
		
	registrarMoeda();
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
	
function incluirPontos(pontos) {
	global.propriedadesJogo.pontos += pontos;
	
	mostrarValorEmJogo(pontos);
}
	
function pausar() {
	var morto = global.propriedadesPlayer.morto;
	var transformando = global.propriedadesPlayer.transformando;
	
	if(!morto && !transformando) {		
		var camadaTiles = layer_get_id("Tiles");
		var pause = global.propriedadesJogo.pause;
		
		if (pause) {
			pause = false;
			
			instance_activate_all();
			
			apagarPrintPause();
			layer_set_visible(camadaTiles, true);
		} else {
			pause = true;

			instance_deactivate_all(true);
			
			printarTelaPause();
			layer_set_visible(camadaTiles, false);
		}
		
		audio_play_sound(sndPause, 1, false);
		
		global.propriedadesJogo.pause = pause;
		global.propriedadesPlayer.parando = true;
	}
}