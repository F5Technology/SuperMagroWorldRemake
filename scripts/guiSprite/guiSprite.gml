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
		case SpriteEnum.LancarProjetil:
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
	
function exibirSpriteDinoKiko(sprite) {
	switch(sprite) {
		case SpriteEnum.Andando:
			if(direcao == DirecaoEnum.Direita) {
				sprite_index = sprDinoKikoAndandoDireita;
			} else {
				sprite_index = sprDinoKikoAndandoEsquerda;
			}
			break;
		case SpriteEnum.Morrendo:
			if(direcao == DirecaoEnum.Direita) {
				layer_sequence_create("Animations", x, y, anDinoKikoMorrendoDireita);
			} else {
				layer_sequence_create("Animations", x, y, anDinoKikoMorrendoEsquerda);
			}
			break;
	}
}
	
function exibirSpriteNaveChefe() {
	var direcao = global.propriedadesChefe.direcao;
	
	if(direcao == DirecaoEnum.Direita) {
		objNave.sprite_index = sprNaveDireita;
	} else {
		objNave.sprite_index = sprNaveEsquerda;
	}
}

function exibirSpriteFlorindaFase1(sprite) {
	var direcao = global.propriedadesChefe.direcao;
	
	switch(sprite) {
		case SpriteEnum.Parado:
			if(direcao == DirecaoEnum.Direita) {
				objFlorinda.sprite_index = sprFlorindaF1Direita;
			} else {
				objFlorinda.sprite_index = sprFlorindaF1Esquerda;
			}
			break;
		case SpriteEnum.LancarProjetil:
			if(direcao == DirecaoEnum.Direita) {
				objFlorinda.sprite_index = sprFlorindaF1LancandoMassaDireita;
			} else {
				objFlorinda.sprite_index = sprFlorindaF1LancandoMassaEsquerda;
			}
			break;
		case SpriteEnum.Aparecendo:
			if(direcao == DirecaoEnum.Direita) {
				objFlorinda.sprite_index = sprFlorindaF1AparecendoDireita;
			} else {
				objFlorinda.sprite_index = sprFlorindaF1AparecendoEsquerda;
			}
			break;
		case SpriteEnum.Escondendo:
			if(direcao == DirecaoEnum.Direita) {
				objFlorinda.sprite_index = sprFlorindaF1EscondendoDireita;
			} else {
				objFlorinda.sprite_index = sprFlorindaF1EscondendoEsquerda;
			}
			break;
	}
}

function exibirSpriteFlorindaFase2(sprite) {
	var direcao = global.propriedadesChefe.direcao;
	
	switch(sprite) {
		case SpriteEnum.Parado:
			if(direcao == DirecaoEnum.Direita) {
				objFlorinda.sprite_index = sprFlorindaF2Direita;
			} else {
				objFlorinda.sprite_index = sprFlorindaF2Esquerda;
			}
			break;
		case SpriteEnum.LancarProjetil:
			if(direcao == DirecaoEnum.Direita) {
				objFlorinda.sprite_index = sprFlorindaF2LancandoMassaDireita;
			} else {
				objFlorinda.sprite_index = sprFlorindaF2LancandoMassaEsquerda;
			}
			break;
		case SpriteEnum.Aparecendo:
			if(direcao == DirecaoEnum.Direita) {
				objFlorinda.sprite_index = sprFlorindaF2AparecendoDireita;
			} else {
				objFlorinda.sprite_index = sprFlorindaF2AparecendoEsquerda;
			}
			break;
		case SpriteEnum.Escondendo:
			if(direcao == DirecaoEnum.Direita) {
				objFlorinda.sprite_index = sprFlorindaF2EscondendoDireita;
			} else {
				objFlorinda.sprite_index = sprFlorindaF2EscondendoEsquerda;
			}
			break;
	}
}

function exibirSpriteFlorindaFase3(sprite) {
	var direcao = global.propriedadesChefe.direcao;
	
	switch(sprite) {
		case SpriteEnum.Parado:
			if(direcao == DirecaoEnum.Direita) {
				objFlorinda.sprite_index = sprFlorindaF3Direita;
			} else {
				objFlorinda.sprite_index = sprFlorindaF3Esquerda;
			}
			break;
		case SpriteEnum.CoolDown:
			if(direcao == DirecaoEnum.Direita) {				
				objFlorinda.sprite_index = sprFlorindaF3CoolDownDireita;
			} else {
				objFlorinda.sprite_index = sprFlorindaF3CoolDownEsquerda;
			}
			break;
	}
}
	
function exibirSpriteShuriken(direcao) {
	if(direcao == DirecaoEnum.Direita) {
		sprite_index = sprShurikenDireita;
	} else {
		sprite_index = sprShurikenEsquerda;
	}
}

function mostrarValorEmJogo(valor) {
	switch(valor) {
		case ValorEnum.Vida:
			layer_sequence_create("Animations", x, y, an1UP);
			break;
		case ValorEnum.Ponto10:
			layer_sequence_create("Animations", x, y, anPontos10);
			break;
		case ValorEnum.Ponto200:
			layer_sequence_create("Animations", x, y, anPontos200);
			break;
		case ValorEnum.Ponto400:
			layer_sequence_create("Animations", x, y, anPontos400);
			break;
		case ValorEnum.Ponto1000:
			layer_sequence_create("Animations", x, y, anPontos1000);
			break;
	}
}

function piscarSprite() {
	if(image_alpha == 1) {
		image_alpha = 0;
	} else {
		image_alpha = 1;
	}
}