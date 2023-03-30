/// @description Sistema de exibição de sprites

function exibirSpriteMadruga(sprite) {
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
	
function exibirSpriteSamurai(sprite) {
	var direcao = global.propriedadesPlayer.direcao;
	
	//Reseta animações para primeiro frame
	//objSeuMadruga.image_index = 0;
	
	switch(sprite) {
		case SpriteEnum.Parado:
			if(direcao == DirecaoEnum.Direita) {
				objSamurai.sprite_index = sprSamuraiParadoDireita;
			} else {
				objSamurai.sprite_index = sprSamuraiParadoEsquerda;
			}
			break;
		case SpriteEnum.Andando:
			if(direcao == DirecaoEnum.Direita) {
				objSamurai.sprite_index = sprSamuraiAndandoDireita;
			} else {
				objSamurai.sprite_index = sprSamuraiAndandoEsquerda;
			}
			break;
		case SpriteEnum.Correndo:
			if(direcao == DirecaoEnum.Direita) {
				objSamurai.sprite_index = sprSamuraiCorrendoDireita;
			} else {
				objSamurai.sprite_index = sprSamuraiCorrendoEsquerda;
			}
			break;
		case SpriteEnum.Abaixado:
			if(direcao == DirecaoEnum.Direita) {
				objSamurai.sprite_index = sprSamuraiAbaixadoDireita;
			} else {
				objSamurai.sprite_index = sprSamuraiAbaixadoEsquerda;
			}
			break;
		case SpriteEnum.Pulando:
			if(direcao == DirecaoEnum.Direita) {
				objSamurai.sprite_index = sprSamuraiPulandoDireita;
			} else {
				objSamurai.sprite_index = sprSamuraiPulandoEsquerda;
			}
			break;
		case SpriteEnum.Caindo:
			if(direcao == DirecaoEnum.Direita) {
				objSamurai.sprite_index = sprSamuraiCaindoDireita;
			} else {
				objSamurai.sprite_index = sprSamuraiCaindoEsquerda;
			}
			break;
		case SpriteEnum.Derrapando:
			if(direcao == DirecaoEnum.Direita) {
				objSamurai.sprite_index = sprSamuraiDerrapandoDireita;
			} else {
				objSamurai.sprite_index = sprSamuraiDerrapandoEsquerda;
			}
			break;
		case SpriteEnum.LancarShuriken:
			//Reseta animações para primeiro frame
			objSeuMadruga.image_index = 0;
			
			if(direcao == DirecaoEnum.Direita) {
				objSamurai.sprite_index = sprSamuraiShurikenDireita;
			} else {
				objSamurai.sprite_index = sprSamuraiShurikenEsquerda;
			}
			break;
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

function checarFimAnimacao(){
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