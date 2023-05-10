/// @description Mecanicas de colisões com elementos

function colisao(tipo, forca){
	var vertical = y;
	var horizontal = x;
	var houveColisao = false;
	var velocidade = global.propriedadesPlayer.velocidade;
	
	switch(tipo) {
		case TipoColisaoEnum.Vertical:
			//Parede
			if(place_meeting(horizontal, vertical + forca, objParede)) {	
				houveColisao = true;
				realizarColisao(TipoColisaoEnum.Vertical, objParede, forca);
			}	
			
			//Bloco de interrogação
			if(place_meeting(horizontal, vertical + forca, objInterrogacao)) {	
				houveColisao = true;
				realizarColisao(TipoColisaoEnum.Vertical, objInterrogacao, forca);
			}	
			
			//Tijolos
			if(place_meeting(horizontal, vertical + forca, objTijolos)) {	
				houveColisao = true;
				realizarColisao(TipoColisaoEnum.Vertical, objTijolos, forca);
			}	
		break;		
		case TipoColisaoEnum.Horizontal:
			//Parede
			if(place_meeting(horizontal + forca, vertical, objParede)) {	
				houveColisao = true;
				realizarColisao(TipoColisaoEnum.Horizontal, objParede, forca);
			}	
			
			//Parede
			if(place_meeting(horizontal + forca, vertical, objLimiteHorizontalPlayer)) {	
				houveColisao = true;
				realizarColisao(TipoColisaoEnum.Horizontal, objLimiteHorizontalPlayer, forca);
			}	
			
			//Bloco de interrogação
			if(place_meeting(horizontal + forca, vertical, objInterrogacao)) {	
				houveColisao = true;
				realizarColisao(TipoColisaoEnum.Horizontal, objInterrogacao, forca);
			}	
			
			//Tijolos
			if(place_meeting(horizontal + forca, vertical, objTijolos)) {	
				houveColisao = true;
				realizarColisao(TipoColisaoEnum.Horizontal, objTijolos, forca);
			}				
		break;
	}
	
	return houveColisao;
}
	
function realizarColisao(tipo, objeto, forca) {
	var posicao = 0;	
	var vertical = y;
	var horizontal = x;
	var aproximacao = sign(forca);
	
	switch(tipo) {
		case TipoColisaoEnum.Vertical:
			posicao = vertical;
			var colisaoTeto = (forca < 0);
			
			while(!place_meeting(horizontal, posicao + aproximacao, objeto)) {
				posicao += aproximacao;
			}
			
			y = posicao;
			global.propriedadesPlayer.forcaGravidade = 0;
			global.propriedadesPlayer.caindo = colisaoTeto;
			
			if(colisaoTeto) {			
				reproduzirSFXPlayer(SFXEnum.BaterTeto);	
			} else {
				exibirSpriteImovel();
			}
			break;
		
		case TipoColisaoEnum.Horizontal:
			posicao = horizontal;
			
			while(!place_meeting(posicao + aproximacao, vertical, objeto)) {
				posicao += aproximacao;
			}
			
			x = posicao;
			global.propriedadesPlayer.velocidade = 0;		
			global.propriedadesPlayer.parando = false;
			break;
	}
}
	
function quebrarTijolos() {
	instance_destroy();
	global.propriedadesPlayer.caindo = true;
	layer_sequence_create("Animations", x, y, anTijolosQuebrados);
}
	
function baterInterrogacao() {	
	if (ativo) {
		ativo = false;
		
		var samurai = global.propriedadesPlayer.samurai;
		var player = samurai ? objSamurai : objSeuMadruga;
		
		y -= sprite_height / 2;		
		player.y += 6;
		
		global.propriedadesPlayer.caindo = true;
		
		alarm[0] = 3;
	}
}

function retornarItemBlocoInterrogacao() {
	if(powerUp) {
		reproduzirSFXElementos(SFXEnum.BlocoInterrogacao);
		instance_create_layer(x, y - sprite_height, "Main", objKanji);
	} else {			
		var instanciaMoeda = instance_create_layer(x, y - sprite_height, "Main", objMoeda);
		
		instanciaMoeda.alarm[0] = 5;
	}
	
	y += sprite_height / 2;	
	sprite_index = sprBlocoVazio;
}
	
function posicionarHitBox() {
	var morto = global.propriedadesPlayer.morto;
	var transformando = global.propriedadesPlayer.transformando;
	
	if(!morto && !transformando) {
		var samurai = global.propriedadesPlayer.samurai;
		var player = samurai ? objSamurai : objSeuMadruga;
		
		x = player.x;
		y = player.y;
	}
}