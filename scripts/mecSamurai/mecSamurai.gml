/// @description Mecanicas referente ao modo samurai

function transformarSamurai() {
	var samurai = global.propriedadesPlayer.samurai;
	
	if (!samurai) {
		instance_destroy();			
		global.sistemasJogo.inteligenciaArtificial = false;
		global.propriedadesPlayer.samurai = true;
		global.propriedadesPlayer.transformando = true;
		global.propriedadesPlayer.trocarSprite = exibirSpriteSamurai;
		instance_create_layer(x, y, "Main", objTransformacao);
	}
	
	incluirPontos(1000);
	
	//Destroi instancia do kanji ao coletar item
	with (other) {
		instance_destroy();
	}
}

function transformarNormal() {
	instance_destroy();		
	global.sistemasJogo.inteligenciaArtificial = false;
	global.propriedadesPlayer.samurai = false;
	global.propriedadesPlayer.transformando = true;
	global.propriedadesPlayer.trocarSprite = exibirSpriteMadruga;
	instance_create_layer(x, y, "Main", objTransformacao);
}

function concluirTransformacao() {
	var samurai = global.propriedadesPlayer.samurai;
	var modo = samurai ? objSamurai : objSeuMadruga;
	
	instance_destroy();	
	instance_create_layer(x, y, "Main", modo);
	
	modo.alarm[0] = 5;
	modo.alarm[1] = 60 * 3; //  3 segundos
	
	global.sistemasJogo.inteligenciaArtificial = true;
	global.propriedadesPlayer.invencivel = true;
	global.propriedadesPlayer.transformando = false;
}
	
function lancarShuriken() {
	var abaixado = global.propriedadesPlayer.abaixado;
	var lancandoShuriken = global.propriedadesPlayer.lancandoShuriken;
	
	if (!lancandoShuriken && !abaixado) {
		global.propriedadesPlayer.lancandoShuriken = true;
		global.propriedadesPlayer.trocarSprite(SpriteEnum.LancarShuriken);
		
		//TODO: Criar intancia da shuriken
	}
}

function finalizarAnimacaoLancarShuriken() {	
	var lancandoShuriken = global.propriedadesPlayer.lancandoShuriken;
	
	if(lancandoShuriken && finalizouAnimacao()) {
		global.propriedadesPlayer.lancandoShuriken = false;
		
		exibirSpriteImovel();
	}
}