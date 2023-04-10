/// @description Funções de troca de salas ou fases diretas

function iniciarSala() {	
	global.sistemasJogo.inteligenciaArtificial = true;
	
	var sistemaTempoAtivo = global.sistemasJogo.tempo;
	reiniciarPropriedadesPlayer();
	reiniciarPropriedadesPrint();
	reiniciarPropriedadesJogo();
	
	if (sistemaTempoAtivo) {
		checarTempo();
	}
}

function reiniciarSala(){
	room_restart();
}