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
	var cenaRodando = global.propriedadesChefe.cenaRodando;
	
	instance_destroy();	
	instance_create_layer(x, y, "Main", modo);
	
	modo.alarm[0] = 5;
	modo.alarm[1] = 60 * 3; //  3 segundos
	
	if(!cenaRodando) {	
		global.sistemasJogo.inteligenciaArtificial = true;
	}
	
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
	var shuriken = instance_create_layer(x, posicaoVertical, "Main", objShuriken);
	
	shuriken.direcao = direcao;
}

function moverShuriken() {
	exibirSpriteShuriken(direcao);
	
	var forca = direcao * 3.5;
	
	x += forca;
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
	}
}