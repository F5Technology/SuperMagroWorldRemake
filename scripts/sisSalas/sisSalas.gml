/// @description Funções de troca de salas ou fases diretas

function iniciarSala() {
	var fase = global.propriedadesJogo.fase;
	global.sistemasJogo.fisicaProjeteisLigado = true;
	global.sistemasJogo.inteligenciaArtificial = true;
	
	if (fase == 3) {
		global.propriedadesJogo.chefe = true;
		reiniciarPropriedadesChefe();
		introduzirChefe();
	} else {	
		var musica = fase == 1 ? sngFase1 : sngFase2;
		var sistemaTempoAtivo = global.sistemasJogo.tempo;
	
		if (sistemaTempoAtivo) {
			checarTempo();
		}
		
		reproduzirMusica(musica, true);
	}
}

function reiniciarSala() {
	room_restart();
}
	
function iniciarTransicaoFase() {
	audio_stop_all();
	alarm[0] = 60 * 3;
}
	
function transicaoFase() {
	var fase = global.propriedadesJogo.fase;
	var samurai = global.propriedadesPlayer.samurai;
	var funcaoTrocarSpritePlayer = global.propriedadesPlayer.trocarSprite;
	
	reiniciarPropriedadesPlayer();
	
	global.propriedadesJogo.tempo = 51;
	global.propriedadesPlayer.samurai = samurai;
	global.propriedadesPlayer.trocarSprite = funcaoTrocarSpritePlayer;
	
	switch (fase) {
		case 1:	
			room_goto(rmFase1);
			break;
		case 2:	
			room_goto(rmFase2);
			break;
		case 3:	
			room_goto(rmChefe);
			break;
	}
}
	
function iniciarJogo() {
	reiniciarPropriedadesPlayer();
	reiniciarPropriedadesPrint();
	reiniciarPropriedadesJogo();
	reiniciarPropriedadesChefe();
	carregarGruposAudios();
	
	room_goto(rmTransicao);
}
	
function checarGameOver() {
	var vidas = global.propriedadesJogo.vidas;
	var sala = vidas >= 0 ? rmTransicao : rmGameOver;
	
	room_goto(sala);
	instance_destroy();
}