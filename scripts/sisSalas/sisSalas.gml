/// @description Funções de troca de salas ou fases diretas

function iniciarSala() {
	var sistemaTempoAtivo = global.sistemaTempoAtivo;
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