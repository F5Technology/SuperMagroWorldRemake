/// @description Sistema de exibição de animações

global.coordenadasAnimacao = {
	padraoChefeX: 208,
	padraoChefeY: 112,
	x: 0,
	y: 0
}

function finalizouAnimacao() {
	var _sprite=sprite_index;
	var _image=image_index;
	
	if(argument_count > 0)   _sprite=argument[0];
	if(argument_count > 1)  _image=argument[1];
	
	var _type=sprite_get_speed_type(sprite_index);
	var _spd=sprite_get_speed(sprite_index)*image_speed;
	
	if(_type == spritespeed_framespersecond)
	    _spd = _spd/room_speed;
		
	if(argument_count > 2) _spd=argument[2];
	return _image+_spd >= sprite_get_number(_sprite);
}
	
function limparCamadaAnimacoesChefe() {
	var camada = layer_get_id("Animations_Boss");
	var animacoes = layer_get_all_elements(camada);

	for (var i = 0; i < array_length(animacoes); i++;)
	{
		layer_sprite_destroy(animacoes[i]);
	}
}
	
function exibirAnimacaoTransformacao() {
	var samurai = global.propriedadesPlayer.samurai;
	var direcao = global.propriedadesPlayer.direcao;
	
	if (samurai) {
		if(direcao == DirecaoEnum.Direita) {
			objTransformacao.sprite_index = sprTransformacaoNormalParaSamuraiDireita;
		} else {
			objTransformacao.sprite_index = sprTransformacaoNormalParaSamuraiEsquerda;
		}
	} else {
		if(direcao == DirecaoEnum.Direita) {
			objTransformacao.sprite_index = sprTransformacaoSamuraiParaNormalDireita;
		} else {
			objTransformacao.sprite_index = sprTransformacaoSamuraiParaNormalEsquerda;
		}
	}
}
	
function removerInstanciaAposAnimacao() {
	if(finalizouAnimacao()) {
		instance_destroy();
	}
}
	
function exibirAnimacaoIntroChefe() {
	var fase = global.propriedadesChefe.fase;
	var posicaoVertical = global.coordenadasAnimacao.padraoChefeY;
	var posicaoHorizontal = global.coordenadasAnimacao.padraoChefeX;
	
	limparCamadaAnimacoesChefe();
	
	switch(fase) {
		case 1:
			layer_sequence_create("Animations_Boss", posicaoHorizontal, posicaoVertical, anFlorindaSurgindoF1);
			break;
		case 2:
			layer_sequence_create("Animations_Boss", posicaoHorizontal, posicaoVertical, anFlorindaSurgindoF2);
			break;
		case 3:
			posicaoVertical = 152;
			layer_sequence_create("Animations_Boss", posicaoHorizontal, posicaoVertical, anFlorindaSurgindoF3);
			break;
	}
	
	global.coordenadasAnimacao.y = posicaoVertical;
	global.coordenadasAnimacao.x = posicaoHorizontal;
}
	
function exibirAnimacaoChefeMorrendo() {
	var direcao = global.propriedadesChefe.direcao;
	
	if(direcao == DirecaoEnum.Direita) {
		layer_sequence_create("Animations_Boss", objNave.x, objNave.y, anFlorindaMorrendoDireita);
	} else {
		layer_sequence_create("Animations_Boss", objNave.x, objNave.y, anFlorindaMorrendoEsquerda);
	}
	
	objCronometrosAnimacoes.alarm[9] = 170;
	global.coordenadasAnimacao.x = objNave.x;
	global.coordenadasAnimacao.y = objNave.y;
}

function exibirAnimacaoChefeTomandoDano() {
	var direcao = global.propriedadesChefe.direcao;
	
	if(direcao == DirecaoEnum.Direita) {
		layer_sequence_create("Animations_Boss", objNave.x, objNave.y, anFlorindaTomandoDanoDireita);
	} else {
		layer_sequence_create("Animations_Boss", objNave.x, objNave.y, anFlorindaTomandoDanoEsquerda);
	}
	
	global.coordenadasAnimacao.x = objNave.x;
	global.coordenadasAnimacao.y = objNave.y;
	
	objCronometrosAnimacoes.alarm[0] = 118;
}

function exibirAnimacaoTransicaoChefeChiquinha() {
	var direcao = global.propriedadesChefe.direcao;
	var posicaoVertical = global.coordenadasAnimacao.y;
	var posicaoHorizontal = global.coordenadasAnimacao.x;
	
	limparCamadaAnimacoesChefe();
	
	if(direcao == DirecaoEnum.Direita) {
		layer_sequence_create("Animations_Boss", posicaoHorizontal, posicaoVertical, anTransicaoFlorindaChiquinhaDireita);
	} else {
		layer_sequence_create("Animations_Boss", posicaoHorizontal, posicaoVertical, anTransicaoFlorindaChiquinhaEsquerda);
	}
	
	objControle.alarm[1] = 220;
	objCronometrosAnimacoes.alarm[2] = 360;
}
	
function exibirAnimacaoPassandoFase() {	
	instance_destroy();
	
	var samurai = global.propriedadesPlayer.samurai;
	var animacao = samurai ? anSamuraiPassandoFase : anMadrugaPassandoFase;
	
	objCronometrosAnimacoes.alarm[7] = 600;
	layer_sequence_create("Animations", objMastro.x + 23, objMastro.y - 1, animacao);
}
	
function checarAnimacao() {
	switch (room) {
		case rmTelaInicial:
			alarm[4] = 300;
			reproduzirMusica(sngTelaInicial, true);
			break;
		case rmIntro:
			alarm[5] = 230;
			break;
		case rmGameOver:
			alarm[6] = 470;
			break;
		case rmCreditos:
			var direcao = global.propriedadesChefe.direcao;
			var animacao = direcao == DirecaoEnum.Direita ? anCreditosDireita : anCreditosEsquerda;
			
			layer_sequence_create("Animations", 128, 112, animacao);
		
			alarm[8] = 10500;
			break;
	}
}
	
function pausarAnimacoes() {
	var animacoes = layer_get_all_elements("Animations");
	
    for (var i = 0; i < array_length(animacoes); i++;)
    {       
		var frameAtual = layer_sequence_get_headpos(animacoes[i]);
		var totalFrames = layer_sequence_get_length(animacoes[i]);
		
		if(frameAtual < totalFrames) {		
			layer_sequence_pause(animacoes[i]);
		} else {
			layer_sprite_destroy(animacoes[i]);
		}
    }
}
	
function pausarAnimacoesChefe() {
	var animacoes = layer_get_all_elements("Animations_Boss");
	
    for (var i = 0; i < array_length(animacoes); i++;)
    {       
		layer_sequence_pause(animacoes[i]);
    }
}

function continuarAnimacoes() {
	var animacoes = layer_get_all_elements("Animations");
	
    for (var i = 0; i < array_length(animacoes); i++;)
    {       
		layer_sequence_play(animacoes[i]);
    }
}
	
function continuarAnimacoesChefe() {
	var animacoes = layer_get_all_elements("Animations_Boss");
	
    for (var i = 0; i < array_length(animacoes); i++;)
    {       
		layer_sequence_play(animacoes[i]);
    }
}
	
function iniciarLoopTelaInicial() {
	var camada = layer_get_id("Animations");
	var animacoes = layer_get_all_elements(camada);

	for (var i = 0; i < array_length(animacoes); i++;)
	{
		layer_sprite_destroy(animacoes[i]);
	}
	
	instance_create_layer(x, y, "Main", objTelaInicial);
	layer_sequence_create("Animations", 128, 112, anTelaInicial);
}
	
function iniciarTransicaoCreditos() {
	limparCamadaAnimacoesChefe();
	
	instance_create_layer(global.coordenadasAnimacao.x, global.coordenadasAnimacao.y, "Top_priority", objNaveVirada);
	exibirSpriteNaveViradaChefe();
		
	global.propriedadesPlayer.fimJogo = true;	
	
	alarm[10] = 300;
}