/// @description Rotinas e mecanicas do chefe final

global.propriedadesChefe = {
	hp: 15,
	fase: 1,
	derrapando: false,
	forcaVertical: 0,
	forcaHorizontal: 0,
	direcao: DirecaoEnum.Esquerda,
	elevacao: ElevacaoEnum.Descer,
	trocarSprite: exibirSpriteFlorindaFase1
}

function reiniciarPropriedadesChefe() {
	global.propriedadesChefe = {
		hp: 15,
		fase: 1,
		derrapando: false,
		forcaVertical: 0,
		forcaHorizontal: 0,
		direcao: DirecaoEnum.Esquerda,
		elevacao: ElevacaoEnum.Descer,
		trocarSprite: exibirSpriteFlorindaFase1
	}
}
	
function executarInteligenciaArtificial() {
	var inteligenciaArtificialLigada = global.sistemasJogo.inteligenciaArtificial;
	
	if(inteligenciaArtificialLigada) {
		movimentoNave();
		seguirNave();
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
	var fase = global.propriedadesChefe.fase;
	var direcao = global.propriedadesChefe.direcao;
	var forcaGravidadeAtual = global.propriedadesChefe.forcaVertical;
	
	switch (fase) {
		case 1:		
		
			#region Movimento Horizontal
			
			var forca = global.propriedadesChefe.forcaHorizontal;
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
			
			var limiteFundo = objNave.y + 33;
			var limiteTopo = objFlorinda.y - 15;
			var elevacao = global.propriedadesChefe.elevacao;
			
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
			break;
		case 3:
			break;
	}
}