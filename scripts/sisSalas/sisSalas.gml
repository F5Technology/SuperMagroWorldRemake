/// @description Funções de troca de salas ou fases diretas

function iniciarSala() {
	global.sistemasJogo.fisicaProjeteisLigado = true;
	global.sistemasJogo.inteligenciaArtificial = true;
	
	var sistemaTempoAtivo = global.sistemasJogo.tempo;
	reiniciarPropriedadesPlayer();
	
	if (sistemaTempoAtivo) {
		checarTempo();
	}
	
	if (room == rmChefe) {
		global.propriedadesJogo.chefe = true;
		introduzirChefe();
	}
}

function reiniciarSala() {
	room_restart();
}
	
function iniciarTransicaoSala() {
	audio_stop_all();
	alarm[0] = 60 * 2.5;
}
	
function transicaoSala() {
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