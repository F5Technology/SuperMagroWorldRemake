/// @description Funções de troca de salas ou fases diretas

function iniciarSala() {
	global.sistemasJogo.fisicaProjeteisLigado = true;
	global.sistemasJogo.inteligenciaArtificial = true;
	
	var sistemaTempoAtivo = global.sistemasJogo.tempo;
	reiniciarPropriedadesPlayer();
	
	reiniciarPropriedadesPrint();
	reiniciarPropriedadesJogo();
	reiniciarPropriedadesChefe();
	carregarGruposAudios();
	
	if (sistemaTempoAtivo) {
		checarTempo();
	}
	
	if (room == rmChefe) {
		global.propriedadesJogo.chefe = true;
		introduzirChefe();
	} else {
		reproduzirMusica(sngFase2, true);
	}
}

function reiniciarSala() {
	room_restart();
}
	
function iniciarTransicaoSala() {
	audio_stop_all();
	alarm[0] = 60 * 3;
}
	
function transicaoSala() {
	global.propriedadesJogo.passandoFase = false;
	//TODO: Sistema de encaminhamento de fases na tela de Transição
	
	room_goto(rmTeste);
}
	
function iniciarJogo() {
	reiniciarPropriedadesPrint();
	reiniciarPropriedadesJogo();
	reiniciarPropriedadesChefe();
	carregarGruposAudios();
	
	room_goto(rmTransicao);
}