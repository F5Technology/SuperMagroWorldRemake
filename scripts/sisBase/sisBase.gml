/// @description Sistema basicos de controle de dados do jogo

global.sistemasJogo = {
	tempo: true,
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
	pause: false,
	passandoFase: false
}

function reiniciarPropriedadesJogo() {
	global.propriedadesJogo = {
		fase: 1,
		mundo: 1,
		vidas: 2,
		tempo: 51,
		pontos: 0,
		moedas: 0,
		pause: false,
		passandoFase: false
	}
}

function registrarMoeda() {
	var moedas = global.propriedadesJogo.moedas;
	
	if (moedas >= 69) {
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
	var segundos = 3;
	var pause = global.propriedadesJogo.pause;
	var morto = global.propriedadesPlayer.morto;
	var passandoFase = global.propriedadesJogo.passandoFase;
	var transformando = global.propriedadesPlayer.transformando;
	
	if(!morto && !transformando && !passandoFase && !pause) {
		var tempo = global.propriedadesJogo.tempo;
	
		tempo--;
		global.propriedadesJogo.tempo = tempo;
		
		if (tempo <= 0) {
			morrer();
		} else {
			
			alarm[0] = 60 * segundos;
		}
	} else {		
		alarm[0] = 60 * segundos;
	}
}
	
function incluirPontos(pontos) {
	global.propriedadesJogo.pontos += pontos;
	
	mostrarValorEmJogo(pontos);
}
	
function pausar() {
	var morto = global.propriedadesPlayer.morto;
	var fimJogo = global.propriedadesPlayer.fimJogo;
	var passandoFase = global.propriedadesJogo.passandoFase;
	var transformando = global.propriedadesPlayer.transformando;
	
	if(!morto && !transformando && !passandoFase && !fimJogo) {		
		var camadaTiles = layer_get_id("Tiles");
		var pause = global.propriedadesJogo.pause;
		
		if (pause) {
			pause = false;
			
			instance_activate_all();
			
			resumirMusicaAtual();
			continuarAnimacoes();
			continuarAnimacoesChefe();
			apagarPrintPause();
			layer_set_visible(camadaTiles, true);
		} else {
			pause = true;

			instance_deactivate_all(true);
			
			pararEfeitosSonoros();
			pausarMusicaAtual();
			pausarAnimacoes();
			pausarAnimacoesChefe();
			printarTelaPause();
			layer_set_visible(camadaTiles, false);
		}
		
		audio_play_sound(sndPause, 1, false);
		
		global.propriedadesJogo.pause = pause;
		global.propriedadesPlayer.parando = true;
	}
}
	
function irProximaFaseJogo() {
	global.propriedadesJogo.fase++;
	global.propriedadesJogo.passandoFase = false;
	
	room_goto(rmTransicao);
}