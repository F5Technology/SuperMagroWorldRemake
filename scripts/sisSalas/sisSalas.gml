/// @description Funções de troca de salas ou fases diretas

function iniciarSala() {	
	global.sistemasJogo.inteligenciaArtificial = true;
	
	var sistemaTempoAtivo = global.sistemasJogo.tempo;
	reiniciarPropriedadesPlayer();
	reiniciarPropriedadesPrint();
	reiniciarPropriedadesJogo();
	reiniciarPropriedadesChefe();
	
	if (sistemaTempoAtivo) {
		checarTempo();
	}
	
	if (room == rmChefe) {
		global.propriedadesJogo.chefe = true;
		introduzirChefe();
	}
}

function reiniciarSala(){
	room_restart();
}