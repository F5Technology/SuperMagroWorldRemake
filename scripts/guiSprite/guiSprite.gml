/// @description Sistema de exibição de sprites

function exibirSpriteMadruga(sprite){
	var direcao = global.propriedadesPlayer.direcao;
	
	//Reseta animações para primeiro frame
	//objSeuMadruga.image_index = 0;
	
	switch(sprite) {
		case SpriteEnum.Parado:
			if(direcao == DirecaoEnum.Direita) {
				objSeuMadruga.sprite_index = sprMadrugaParadoDireita;
			} else {
				objSeuMadruga.sprite_index = sprMadrugaParadoEsquerda;
			}
			break;
		case SpriteEnum.Andando:
			if(direcao == DirecaoEnum.Direita) {
				objSeuMadruga.sprite_index = sprMadrugaAndandoDireita;
			} else {
				objSeuMadruga.sprite_index = sprMadrugaAndandoEsquerda;
			}
			break;
		case SpriteEnum.Correndo:
			if(direcao == DirecaoEnum.Direita) {
				objSeuMadruga.sprite_index = sprMadrugaCorrendoDireita;
			} else {
				objSeuMadruga.sprite_index = sprMadrugaCorrendoEsquerda;
			}
			break;
		case SpriteEnum.Abaixado:
			if(direcao == DirecaoEnum.Direita) {
				objSeuMadruga.sprite_index = sprMadrugaAbaixadoDireita;
			} else {
				objSeuMadruga.sprite_index = sprMadrugaAbaixadoEsquerda;
			}
			break;
		case SpriteEnum.Pulando:
			if(direcao == DirecaoEnum.Direita) {
				objSeuMadruga.sprite_index = sprMadrugaPulandoDireita;
			} else {
				objSeuMadruga.sprite_index = sprMadrugaPulandoEsquerda;
			}
			break;
		case SpriteEnum.Caindo:
			if(direcao == DirecaoEnum.Direita) {
				objSeuMadruga.sprite_index = sprMadrugaCaindoDireita;
			} else {
				objSeuMadruga.sprite_index = sprMadrugaCaindoEsquerda;
			}
			break;
		case SpriteEnum.Derrapando:
			if(direcao == DirecaoEnum.Direita) {
				objSeuMadruga.sprite_index = sprMadrugaDerrapandoDireita;
			} else {
				objSeuMadruga.sprite_index = sprMadrugaDerrapandoEsquerda;
			}
			break;
	}
}