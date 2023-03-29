/// @description Mecanicas referente ao modo samurai

function transformarSamurai() {
	var samurai = global.propriedadesPlayer.samurai;
	
	if (!samurai) {
		instance_destroy();	
		global.propriedadesPlayer.samurai = true;
		global.propriedadesPlayer.transformando = true;
		global.propriedadesPlayer.trocarSprite = exibirSpriteSamurai;
		instance_create_layer(x, y, "Instances", objTransformacao);
	}
	
	//Destroi instancia do kanji ao coletar item
	with (other) {
		instance_destroy();
	}
}

function transformarNormal() {
	instance_destroy();	
	global.propriedadesPlayer.samurai = false;
	global.propriedadesPlayer.transformando = true;
	global.propriedadesPlayer.trocarSprite = exibirSpriteMadruga;
	instance_create_layer(x, y, "Instances", objTransformacao);
}

function concluirTransformacao() {
	var samurai = global.propriedadesPlayer.samurai;
	var modo = samurai ? objSamurai : objSeuMadruga;
	
	instance_destroy();	
	instance_create_layer(x, y, "Instances", modo);
	
	global.propriedadesPlayer.transformando = false;
}