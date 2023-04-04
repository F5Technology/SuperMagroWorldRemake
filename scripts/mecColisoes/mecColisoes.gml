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
			var colisaoTeto = (posicao + forca < 0);
			
			while(!place_meeting(horizontal, posicao + aproximacao, objeto)) {
				posicao += aproximacao;
			}
			
			y = posicao;
			global.propriedadesPlayer.forcaGravidade = 0;
			global.propriedadesPlayer.caindo = colisaoTeto;
			
			if(!colisaoTeto) {				
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