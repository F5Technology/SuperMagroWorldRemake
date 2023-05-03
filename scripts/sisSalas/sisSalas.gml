/// @description Funções de troca de salas ou fases diretas

function iniciarSala() {
	global.sistemasJogo.fisicaProjeteisLigado = true;
	global.sistemasJogo.inteligenciaArtificial = true;
	
	var sistemaTempoAtivo = global.sistemasJogo.tempo;
	reiniciarPropriedadesPlayer();
	reiniciarPropriedadesPrint();
	reiniciarPropriedadesJogo();
	reiniciarPropriedadesChefe();
	
	audio_group_load(sfxPlayer);
	audio_group_load(sfxElementos);
	
	if (sistemaTempoAtivo) {
		checarTempo();
	}
	
	if (room == rmChefe) {
		audio_group_load(sfxChefe);
		global.propriedadesJogo.chefe = true;
		introduzirChefe();
	}
}

function reiniciarSala() {
	room_restart();
}
	
function transicaoSala() {
	//TODO: Sistema de encaminhamento de fases na tela de Transição
	
	room_goto(rmTeste);
}