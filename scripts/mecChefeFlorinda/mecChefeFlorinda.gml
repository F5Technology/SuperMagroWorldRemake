/// @description Rotinas e mecanicas do chefe final

global.propriedadesChefe = {
	hp: 15,
	fase: 1,
	forcaVertical: 0,
	forcaHorizontal: 0,
	derrapando: false,
	cenaRodando: false,
	contadorCoolDown: 25,
	inimigosSumonados: false,
	aguardandoAterrissagem: false,
	direcao: DirecaoEnum.Esquerda,
	elevacao: ElevacaoEnum.Descer,
	situacao: SituacaoChefeEnum.Ativo,
	trocarSprite: exibirSpriteFlorindaFase1
}

function reiniciarPropriedadesBasicasChefe() {
	global.propriedadesChefe.forcaVertical = 0;
	global.propriedadesChefe.forcaHorizontal = 0;
	global.propriedadesChefe.derrapando = false;
	global.propriedadesChefe.cenaRodando = false;
	global.propriedadesChefe.direcao = DirecaoEnum.Esquerda;
	global.propriedadesChefe.elevacao = ElevacaoEnum.Descer;
	global.propriedadesChefe.situacao = SituacaoChefeEnum.Ativo;
	
	global.sistemasJogo.inteligenciaArtificial = true;
}

function reiniciarPropriedadesChefe() {
	global.propriedadesChefe = {
		hp: 15,
		fase: 1,
		forcaVertical: 0,
		forcaHorizontal: 0,
		derrapando: false,
		cenaRodando: false,
		contadorCoolDown: 25,
		inimigosSumonados: false,
		aguardandoAterrissagem: false,
		direcao: DirecaoEnum.Esquerda,
		elevacao: ElevacaoEnum.Descer,
		situacao: SituacaoChefeEnum.Ativo,
		trocarSprite: exibirSpriteFlorindaFase1
	}
}
	
function executarInteligenciaArtificial() {
	var situacao = global.propriedadesChefe.situacao;
	var inteligenciaArtificialLigada = global.sistemasJogo.inteligenciaArtificial;
	
	if(inteligenciaArtificialLigada) {
		switch(situacao) {
			case SituacaoChefeEnum.Ativo:
				movimentoNave();
				seguirNave();
				checarAterrissagem();
				break;
			case SituacaoChefeEnum.SumonandoInimigos:
				if(finalizouAnimacao()) {
					concluirSumonInimigos();
				}
				break;
			case SituacaoChefeEnum.Aterrissando:
				aterrissar();
				break;
			case SituacaoChefeEnum.ConcluirAterrisagem:
				if(finalizouAnimacao()) {
					global.propriedadesChefe.situacao = SituacaoChefeEnum.Atacando; 
					
					global.propriedadesChefe.trocarSprite(SpriteEnum.LancarProjetil);
				}
				break;
			case SituacaoChefeEnum.Atacando:
				lancandoMassaMacarrao();
				break;
			case SituacaoChefeEnum.CoolDown:
				global.propriedadesChefe.trocarSprite(SpriteEnum.CoolDown);
				break;
		}
	}
}

function seguirNave() {
	objFlorinda.x = objNave.x;
	objFlorinda.y = objNave.y - 55;
}

function alterarDirecao() {	
	var direcao = global.propriedadesChefe.direcao;
	
	if(direcao == DirecaoEnum.Direita) {
		global.propriedadesChefe.direcao = DirecaoEnum.Esquerda;
	} else {
		global.propriedadesChefe.direcao = DirecaoEnum.Direita;
	}
}

function movimentoNave() {
	var limiteTopo = 0;
	var limiteFundo = 0;
	var fase = global.propriedadesChefe.fase;
	var direcao = global.propriedadesChefe.direcao;
	var elevacao = global.propriedadesChefe.elevacao;
	var forca = global.propriedadesChefe.forcaHorizontal;
	var forcaGravidadeAtual = global.propriedadesChefe.forcaVertical;
	
	switch (fase) {
		case 1:		
		
			#region Movimento Horizontal
			
			var limiteParada = objNave.x + (direcao * 20);
			var limiteDerrapagem = limiteParada + (forca * 28);
			
			if(place_meeting(limiteParada, objNave.y, objLimiteMovimentoInimigo)) {
				forca = 0;
				alterarDirecao();		
				global.propriedadesChefe.derrapando = false;
			} else if(place_meeting(limiteDerrapagem, objNave.y, objLimiteMovimentoInimigo)) {	
				var derrapando = global.propriedadesChefe.derrapando;
				
				forca -= (direcao * 0.001);		
		
				if(!derrapando) {
					//Altera a direção só pra mudar o sprite
					alterarDirecao();

					exibirSpriteNaveChefe();
					global.propriedadesChefe.trocarSprite(SpriteEnum.Parado);				
			
					//Volta para a direção para concluir o trajeto derrapando
					global.propriedadesChefe.direcao = direcao;
					global.propriedadesChefe.derrapando = true;
				}
			} else if(forcaGravidadeAtual > 0.20 || forcaGravidadeAtual < -0.20) {	//Se movimenta quando começa a subida ou a descida
				var velocidadeMaxima = (direcao * 2.6);
				var velocidadeMinima = (direcao * 0.090);
				
				if((direcao == DirecaoEnum.Direita && forca >= velocidadeMaxima) 
				|| (direcao == DirecaoEnum.Esquerda && forca <= velocidadeMaxima)) {
					forca = velocidadeMaxima;
				} else {
					forca += velocidadeMinima;
				}				
			}
			
			objNave.x += forca;
			global.propriedadesChefe.forcaHorizontal = forca;
			
			#endregion
			
			#region Movimento Vertical
			
			limiteFundo = objNave.y + 33;
			limiteTopo = objFlorinda.y - 15;
			
			if(place_meeting(objNave.x, limiteFundo, objLimiteVerticalChefe)) {
				elevacao = ElevacaoEnum.Subir;
			} else if(place_meeting(objFlorinda.x, limiteTopo, objLimiteVerticalChefe)) {	
				forcaGravidadeAtual = 0;
				elevacao = ElevacaoEnum.Descer;
			}
			
			forcaGravidadeAtual += (elevacao * 0.0940);
			
			objNave.y += forcaGravidadeAtual;
			
			global.propriedadesChefe.elevacao = elevacao;
			global.propriedadesChefe.forcaVertical = forcaGravidadeAtual;
			
			#endregion
			
			break;
		case 2:
			
			#region Movimento Horizontal
			
			var limiteForca = (direcao * 1.8);
			var samurai = global.propriedadesPlayer.samurai;
			var player = samurai ? objSamurai : objSeuMadruga;
			var derrapando = global.propriedadesChefe.derrapando;
			var indoParaDireita = (direcao == DirecaoEnum.Direita);
			var indoParaEsquerda = (direcao == DirecaoEnum.Esquerda);
			var limiteDireita = obterValorDePorcentagem(85, room_width);
			var limiteEsquerda = obterValorDePorcentagem(15, room_width);
			
			if(player.x > limiteEsquerda && player.x < limiteDireita) {
				limiteDireita = player.x;
				limiteEsquerda = player.x;
			} else if (player.x >= limiteDireita) {
				limiteEsquerda = limiteDireita;
			} else if (player.x <= limiteEsquerda) {
				limiteDireita = limiteEsquerda;
			}
			
			if(derrapando) {
				forca -= (direcao * 0.050);
			} else if ((indoParaDireita && forca < limiteForca) || (indoParaEsquerda && forca > limiteForca)) {
				forca += (direcao * 0.050);
			} else {
				forca = limiteForca;
			}
			
			if(forca == 0) {
				alterarDirecao();
				derrapando = false;
				
				exibirSpriteNaveChefe();
				global.propriedadesChefe.trocarSprite(SpriteEnum.Parado);
			} else if ((indoParaDireita && objNave.x >= limiteDireita) 
					|| (indoParaEsquerda && objNave.x <= limiteEsquerda)) {
				derrapando = true;
			}
			
			objNave.x += forca;
			
			global.propriedadesChefe.derrapando = derrapando;
			global.propriedadesChefe.forcaHorizontal = forca;
			
			#endregion
			
			#region Movimento Vertical
			
			limiteFundo = objNave.y + 53;
			
			if(place_meeting(objNave.x, limiteFundo, objLimiteVerticalChefe)) {
				elevacao = ElevacaoEnum.Subir;
			} else if(elevacao == ElevacaoEnum.Subir) {	
				elevacao = ElevacaoEnum.Descer;
			}
			
			forcaGravidadeAtual += (elevacao * 0.1);
			
			objNave.y += forcaGravidadeAtual;
			
			global.propriedadesChefe.elevacao = elevacao;
			global.propriedadesChefe.forcaVertical = forcaGravidadeAtual;
			
			#endregion
			
			break;
		case 3:
			
			#region Movimento Horizontal
			
			forca = (direcao * 1.8);
			objNave.x += forca;
			
			var limiteColisao = objNave.x + forca * 10;
			
			if(place_meeting(limiteColisao, objNave.y, objLimiteMovimentoInimigo)) {
				alterarDirecao();
				
				exibirSpriteNaveChefe();
				global.propriedadesChefe.trocarSprite(SpriteEnum.Parado);
			}
			
			#endregion
			
			#region Movimento Vertical
			
			limiteTopo = objFlorinda.y - 65;
			
			if(place_meeting(objFlorinda.x, limiteTopo, objLimiteVerticalChefe)) {
				elevacao = ElevacaoEnum.Descer;
			} else if (place_meeting(objNave.x, objNave.y, objLimiteVerticalChefe)) {	
				with (objLimiteVerticalChefe) {
					limiteFundo = y - sprite_height + 220;
					
					if(limiteFundo <= objNave.y) {
						var contadorCoolDown = global.propriedadesChefe.contadorCoolDown;
						
						contadorCoolDown--;
						
						if(contadorCoolDown > 0) {
							elevacao = ElevacaoEnum.Subir;
							forcaGravidadeAtual = elevacao * 2;
						} else {
							global.propriedadesChefe.situacao = SituacaoChefeEnum.CoolDown;
						}
						
						global.propriedadesCamera.tremer = true;
						objCronometrosAnimacoes.alarm[3] = 5;
						
						global.propriedadesChefe.contadorCoolDown = contadorCoolDown;
					}
				}
			}
			
			forcaGravidadeAtual += (elevacao * 0.1);
			
			objNave.y += forcaGravidadeAtual;
			
			global.propriedadesChefe.elevacao = elevacao;
			global.propriedadesChefe.forcaVertical = forcaGravidadeAtual;
			
			#endregion
			
			break;
	}
}
	
function irProximaFase() {
	var fase = global.propriedadesChefe.fase;
	
	fase++;
	
	if(fase == 2) {
		global.propriedadesChefe.trocarSprite = exibirSpriteFlorindaFase2;
	} else if (fase == 3) {
		global.propriedadesChefe.trocarSprite = exibirSpriteFlorindaFase3;
	}
	
	global.propriedadesChefe.fase = fase;
}

function derrotarChefe() {
	var fase = global.propriedadesChefe.fase;
	
	if(fase < 3) {
		irProximaFase();
		exibirAnimacaoChefeTomandoDano();
	} else {
		exibirAnimacaoChefeMorrendo();
	}
	
	global.propriedadesChefe.cenaRodando = true;
	global.sistemasJogo.inteligenciaArtificial = false;
	
	instance_destroy(objNave);
	instance_destroy(objFlorinda);	
}

function receberDanoPulo() {
	var fase = global.propriedadesChefe.fase;
	var situacao = global.propriedadesChefe.situacao;
	
	if ((fase < 3 && situacao != SituacaoChefeEnum.Aterrissando) || situacao == SituacaoChefeEnum.CoolDown) {
		var limiteHit = y - 15;
		var coordernadaHit = objHitBoxBottom.y - 6;
		
		if(coordernadaHit <= limiteHit) {
			derrotarChefe();
	
			global.propriedadesPlayer.caindo = false;
			global.propriedadesPlayer.forcaGravidade = -2;
			
			aplicarGravidadePlayer(true);
		}
	}
}
	
function derrubarEmblema() {
	var posicaoHorizontal = global.coordenadasAnimacao.x;
	var posicaoVertical = global.coordenadasAnimacao.y - 64;
	
	var emblema = instance_create_layer(posicaoHorizontal, posicaoVertical, "Main", objKanji);
	
	emblema.derrubado = true;
	emblema.forcaGravidadeAtual = -5.2;
}

function introduzirChefe() {
	exibirAnimacaoIntroChefe();
	global.propriedadesChefe.cenaRodando = true;
	
	objCronometrosAnimacoes.alarm[1] = 844;
}
	
function iniciarLuta() {
	var fase = global.propriedadesChefe.fase;
	var posicaoVertical = global.coordenadasAnimacao.y;
	var posicaoHorizontal = global.coordenadasAnimacao.x;
	
	limparCamadaAnimacoesChefe();
	reiniciarPropriedadesBasicasChefe();
	
	var instanciaChefe = instance_create_layer(posicaoHorizontal, posicaoVertical, "Main", objFlorinda);
	instance_create_layer(posicaoHorizontal, posicaoVertical, "Main", objNave);
	
	global.propriedadesChefe.trocarSprite(SpriteEnum.Parado);
	
	if (fase == 1) {
		instanciaChefe.alarm[1] = 60 * 8;
	} else if(fase == 2) {
		instanciaChefe.alarm[0] = 60 * 8;
	} else if (fase == 3) {
		//TODO: Inserir alarm de CoolDown
	}
	
	seguirNave();
}
	
function sumonarInimigos() {
	global.propriedadesChefe.situacao = SituacaoChefeEnum.SumonandoInimigos;	
	
	global.propriedadesChefe.trocarSprite(SpriteEnum.Escondendo);
}
	
function concluirSumonInimigos() {
	var inimigosSumonados = global.propriedadesChefe.inimigosSumonados;
	
	if (inimigosSumonados) {
		global.propriedadesChefe.trocarSprite(SpriteEnum.Parado);
		global.propriedadesChefe.situacao = SituacaoChefeEnum.Ativo;
		
		
		alarm[1] = 60 * 8;
	} else {
		var limiteLancamento = 15;
		var posicaoVertical = y + 15;
		
		var inimigoDireita = instance_create_layer(x, posicaoVertical, "Secondary", objDinoKiko);
		var inimigoEsquerda = instance_create_layer(x, posicaoVertical, "Secondary", objDinoKiko);
		
		inimigoDireita.forcaGravidadeAtual = -3.5;
		inimigoEsquerda.forcaGravidadeAtual = -3.5;
		inimigoEsquerda.direcao = DirecaoEnum.Esquerda;
		inimigoEsquerda.sprite_index = sprDinoKikoAndandoEsquerda;
		
		global.propriedadesChefe.inimigosSumonados = true;
		global.propriedadesChefe.trocarSprite(SpriteEnum.Aparecendo);
	}
}
	
function checarAterrissagem() {
	var aguardandoAterrissagem = global.propriedadesChefe.aguardandoAterrissagem;
	
	if (aguardandoAterrissagem) {
		var aterrisar = false;
		var fase = global.propriedadesChefe.fase;	
		var samurai = global.propriedadesPlayer.samurai;
		var player = samurai ? objSamurai : objSeuMadruga;	
		
		var limitePlayerDireita = player.x + 10;
		var limitePlayerEsquerda = player.x - 10;
		
		var limiteSalaDireita = obterValorDePorcentagem(85, room_width);
		var limiteSalaEsquerda = obterValorDePorcentagem(15, room_width);
		
		if (x > limitePlayerEsquerda && x < limitePlayerDireita) {
			aterrisar = true;
		} else if (player.x >= limiteSalaDireita || player.x <= limiteSalaEsquerda) {					
			switch (fase) {
				case 1:
				
					show_debug_message(y);
					
					aterrisar = (y < 53 &&
								((player.x <= limiteSalaEsquerda && x < limiteSalaEsquerda + 10) || 
								(player.x >= limiteSalaDireita && x > limiteSalaDireita - 10)));
					break;
				case 2:					
					aterrisar = ((player.x <= limiteSalaEsquerda && x > limiteSalaEsquerda) || 
								(player.x >= limiteSalaDireita && x < limiteSalaDireita));		
					break;
			}
		}
		
		if (aterrisar) {
			global.propriedadesChefe.situacao = SituacaoChefeEnum.Aterrissando; 
		
			exibirSpriteNaveChefe();
			global.propriedadesChefe.trocarSprite(SpriteEnum.Escondendo);
		}
	}
}
	
function aterrissar() {
	var aguardandoAterrissagem = global.propriedadesChefe.aguardandoAterrissagem;
	
	if (aguardandoAterrissagem) {
		if (finalizouAnimacao()) {
			visible = false;
			global.propriedadesChefe.aguardandoAterrissagem = false;
		}
		
	} else {
		objNave.y += 10;
		seguirNave();
		
		if (place_meeting(objNave.x, objNave.y - 20, objParede)) {			
			visible = true;		
			exibirSpriteNaveChefe();	
			
			global.propriedadesCamera.tremer = true;
			global.propriedadesChefe.trocarSprite(SpriteEnum.Aparecendo);
			global.propriedadesChefe.situacao = SituacaoChefeEnum.ConcluirAterrisagem; 
			
			objCronometrosAnimacoes.alarm[3] = 10;
		}
	}
}

function lancandoMassaMacarrao() {
	var samurai = global.propriedadesPlayer.samurai;
	var player = samurai ? objSamurai : objSeuMadruga;
	
	if(x < player.x) {
		global.propriedadesChefe.direcao = DirecaoEnum.Direita;		
	} else {
		global.propriedadesChefe.direcao = DirecaoEnum.Esquerda;
	}
				
	exibirSpriteNaveChefe();
	global.propriedadesChefe.trocarSprite(SpriteEnum.LancarProjetil);
	//TODO: Lancar projetil massa macarrão
}