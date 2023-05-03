/// @description Sistemas de reprodução de efeitos sonoros

function reproduzirSFXPlayer(sfx) {
	if(sfx != SFXEnum.Pular) {
		audio_group_stop_all(sfxPlayer);
	}
	
	switch (sfx) {
		case SFXEnum.Pular:
		
			var caindo = global.propriedadesPlayer.caindo;
			var forcaGravidade = global.propriedadesPlayer.forcaGravidade;
			var lancandoShuriken = global.propriedadesPlayer.lancandoShuriken;
	
			if(forcaGravidade == 0 && !lancandoShuriken && !caindo) {
				audio_group_stop_all(sfxPlayer);
				audio_play_sound(sndPular, 1, false);
			}
			
			break;
		case SFXEnum.TransformarSamurai:
			audio_play_sound(sndTransformarSamurai, 1, false);
			break;
		case SFXEnum.TransformarNormal:
			audio_play_sound(sndTransformarNormal, 1, false);
			break;
		case SFXEnum.DispararShuriken:
			audio_play_sound(sndDispararShuriken, 1, false);
			break;
		case SFXEnum.BaterTeto:
			audio_play_sound(sndBaterTeto, 1, false);
			break;
	}
}
	
function reproduzirSFXElementos(sfx) {
	audio_group_stop_all(sfxElementos);
	
	switch (sfx) {
		case SFXEnum.Moeda:		
			audio_play_sound(sndMoeda, 1, false);
			break;
		case SFXEnum.BlocoInterrogacao:		
			audio_play_sound(sndDroparEmblemaBloco, 1, false);
			break;
	}
}

function reproduzirSFXChefe(sfx) {
	audio_group_stop_all(sfxChefe);
	
	switch (sfx) {
		case SFXEnum.Tremer:		
			audio_play_sound(sndTremer, 1, false);
			break;
		case SFXEnum.SumonarInimigos:		
			audio_play_sound(sndSumonarInimigos, 1, false);
			break;
		case SFXEnum.DanoShuriken:		
			audio_play_sound(sndDanoChefeShuriken, 1, false);
			break;
	}
}