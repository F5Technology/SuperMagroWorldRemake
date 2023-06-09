/// @description Mecanicas referente ao modo samurai

function transformarSamurai() {
	var samurai = global.propriedadesPlayer.samurai;
	
	if (!samurai) {
		instance_destroy(objHitBoxTop);
		instance_destroy(objHitBoxBottom);
		instance_destroy();	
		
		reproduzirSFXPlayer(SFXEnum.TransformarSamurai);
		global.sistemasJogo.fisicaProjeteisLigado = false;		
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
	instance_destroy(objHitBoxTop);
	instance_destroy(objHitBoxBottom);
	instance_destroy();
	
	reproduzirSFXPlayer(SFXEnum.TransformarNormal);
	global.sistemasJogo.fisicaProjeteisLigado = false;
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
	
	global.sistemasJogo.fisicaProjeteisLigado = true;
	global.sistemasJogo.inteligenciaArtificial = true;
	
	global.propriedadesPlayer.invencivel = true;
	global.propriedadesPlayer.transformando = false;
}
	
function lancarShuriken() {
	var abaixado = global.propriedadesPlayer.abaixado;
	var derrapando = global.propriedadesPlayer.derrapando;
	var lancandoShuriken = global.propriedadesPlayer.lancandoShuriken;
	
	if (!lancandoShuriken && !abaixado && !derrapando) {
		global.propriedadesPlayer.lancandoShuriken = true;
		global.propriedadesPlayer.trocarSprite(SpriteEnum.LancarProjetil);
		
		alarm[2] = 6;
	}
}

function finalizarAnimacaoLancarShuriken() {	
	var lancandoShuriken = global.propriedadesPlayer.lancandoShuriken;
	
	if(lancandoShuriken && finalizouAnimacao()) {
		global.propriedadesPlayer.lancandoShuriken = false;
		
		exibirSpriteImovel();
	}
}
	
function criarShuriken() {
	var posicaoVertical = y - 10;
	var direcao = global.propriedadesPlayer.direcao;
	var shuriken = instance_create_layer(x, posicaoVertical, "Secondary", objShuriken);
	
	shuriken.direcao = direcao;	
	reproduzirSFXPlayer(SFXEnum.DispararShuriken);
}

function moverShuriken() {
	var fisicaProjeteisLigado = global.sistemasJogo.fisicaProjeteisLigado;
	
	if (fisicaProjeteisLigado) {
		exibirSpriteShuriken(direcao);
	
		x += direcao * 3.5;
	}
}

function shurikenNoInimigo() {
	instance_destroy();
	
	with(other) {
		serMorto();
	}
}
	
function shurikenNoChefe() {
	instance_destroy();
	
	var hpChefe = global.propriedadesChefe.hp;
	
	hpChefe--;
	
	if(hpChefe == 0) {
		derrotarChefe();
	} else {
		objNave.hit = true;
		objFlorinda.hit = true;
		
		objNave.alarm[0] = 5;
		objFlorinda.alarm[2] = 5;
		
		global.propriedadesChefe.hp = hpChefe;
		reproduzirSFXChefe(SFXEnum.DanoShuriken);
	}
}
	
function checarSamuraiInicioFase() {
	var samurai = global.propriedadesPlayer.samurai;
	
	if (samurai) {
		instance_destroy(objHitBoxTop);
		instance_destroy(objHitBoxBottom);
		instance_destroy(objSeuMadruga);
		
		instance_create_layer(x, y, "Main", objSamurai);	
	}
}