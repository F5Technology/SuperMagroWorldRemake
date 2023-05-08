/// @description Integração com Gamepad

global.slot = 0;
global.gamepadAtivo = false;
global.direcaoAnalogico = {
	Direito: DirecaoEnum.Neutro,
	Esquerdo: DirecaoEnum.Neutro
}

function obterGamepadAtivo() {
	var gamepad = {
		cima: {
			down: gamepad_button_check(global.slot, gp_padu),
			up: gamepad_button_check_released(global.slot, gp_padu),
			pressed: gamepad_button_check_pressed(global.slot, gp_padu)
		},
		baixo: {
			down: gamepad_button_check(global.slot, gp_padd),
			up: gamepad_button_check_released(global.slot, gp_padd),
			pressed: gamepad_button_check_pressed(global.slot, gp_padd)
		},
		direita: {
			down: gamepad_button_check(global.slot, gp_padr),
			up: gamepad_button_check_released(global.slot, gp_padr),
			pressed: gamepad_button_check_pressed(global.slot, gp_padr)
		},
		esquerda: {
			down: gamepad_button_check(global.slot, gp_padl),
			up: gamepad_button_check_released(global.slot, gp_padl),
			pressed: gamepad_button_check_pressed(global.slot, gp_padl)
		},
		start: {
			down: gamepad_button_check(global.slot, gp_start),
			up: gamepad_button_check_released(global.slot, gp_start),
			pressed: gamepad_button_check_pressed(global.slot, gp_start)
		},
		select: {
			down: gamepad_button_check(global.slot, gp_select),
			up: gamepad_button_check_released(global.slot, gp_select),
			pressed: gamepad_button_check_pressed(global.slot, gp_select)
		},
		botaoB: {
			down: gamepad_button_check(global.slot, gp_face1),
			up: gamepad_button_check_released(global.slot, gp_face1),
			pressed: gamepad_button_check_pressed(global.slot, gp_face1)
		},
		botaoA: {
			down: gamepad_button_check(global.slot, gp_face2),
			up: gamepad_button_check_released(global.slot, gp_face2),
			pressed: gamepad_button_check_pressed(global.slot, gp_face2)
		},
		botaoY: {
			down: gamepad_button_check(global.slot, gp_face3),
			up: gamepad_button_check_released(global.slot, gp_face3),
			pressed: gamepad_button_check_pressed(global.slot, gp_face3)
		},
		botaoX: {
			down: gamepad_button_check(global.slot, gp_face4),
			up: gamepad_button_check_released(global.slot, gp_face4),
			pressed: gamepad_button_check_pressed(global.slot, gp_face4)
		},
		analogicoDir: {
			down: gamepad_button_check(global.slot, gp_stickr),
			up: gamepad_button_check_released(global.slot, gp_stickr),
			pressed: gamepad_button_check_pressed(global.slot, gp_stickr),
			speed: obterVelocidadeAnalogico(DirecaoEnum.Direita),
			direction: obterDirecaoAnalogico(DirecaoEnum.Direita),
		},
		analogicoEsqu: {
			down: gamepad_button_check(global.slot, gp_stickl),
			up: gamepad_button_check_released(global.slot, gp_stickl),
			pressed: gamepad_button_check_pressed(global.slot, gp_stickl),
			speed: obterVelocidadeAnalogico(DirecaoEnum.Esquerda),
			direction: obterDirecaoAnalogico(DirecaoEnum.Esquerda)
		},
		botaoR1: {
			down: gamepad_button_check(global.slot, gp_shoulderr),
			up: gamepad_button_check_released(global.slot, gp_shoulderr),
			pressed: gamepad_button_check_pressed(global.slot, gp_shoulderr)
		},
		botaoR2: {
			down: gamepad_button_check(global.slot, gp_shoulderrb),
			up: gamepad_button_check_released(global.slot, gp_shoulderrb),
			pressed: gamepad_button_check_pressed(global.slot, gp_shoulderrb)
		},
		botaoL1: {
			down: gamepad_button_check(global.slot, gp_shoulderl),
			up: gamepad_button_check_released(global.slot, gp_shoulderl),
			pressed: gamepad_button_check_pressed(global.slot, gp_shoulderl)
		},
		botaoL2: {
			down: gamepad_button_check(global.slot, gp_shoulderlb),
			up: gamepad_button_check_released(global.slot, gp_shoulderlb),
			pressed: gamepad_button_check_pressed(global.slot, gp_shoulderlb)
		}
	}
	
	return gamepad;
}

function checagemGamepadsConectados() {
	var slot = 0;
	var controlesConectados = 0;
	var dispositivosConectados = gamepad_get_device_count();
	
	for (var i = 0; i < dispositivosConectados; i++;)
	{
	    if (gamepad_is_connected(i)) {
			controlesConectados++;
			slot = i;
		}
	}
	
	if (controlesConectados > 0) {
		global.slot = slot;
		global.gamepadAtivo = true;
		
		show_debug_message("Modo Gamepad Ligado");
	} else {
		global.gamepadAtivo = false;
		
		show_debug_message("Modo Gamepad Desligado");
	}
}
	
function obterDirecaoAnalogico(analogico) {
	var valorVertical = 0;
	var valorHorizontal = 0;
	
	if(analogico == DirecaoEnum.Direita) {
		valorVertical = gamepad_axis_value(global.slot, gp_axisrv);
		valorHorizontal = gamepad_axis_value(global.slot, gp_axisrh);
	} else if (analogico == DirecaoEnum.Esquerda) {
		valorVertical = gamepad_axis_value(global.slot, gp_axislv);
		valorHorizontal = gamepad_axis_value(global.slot, gp_axislh);
	} else {		
		return 0;
	}
	
	return point_direction(0, 0, valorHorizontal, valorVertical);
}

function obterVelocidadeAnalogico(analogico) {
	var valorVertical = 0;
	var valorHorizontal = 0;
	
	if(analogico == DirecaoEnum.Direita) {
		valorVertical = gamepad_axis_value(global.slot, gp_axisrv);
		valorHorizontal = gamepad_axis_value(global.slot, gp_axisrh);
	} else if (analogico == DirecaoEnum.Esquerda) {
		valorVertical = gamepad_axis_value(global.slot, gp_axislv);
		valorHorizontal = gamepad_axis_value(global.slot, gp_axislh);
	} else {		
		return 0;
	}
	
	return point_distance(0, 0, valorHorizontal, valorVertical) * 5;
}
	
function checagemComandoPauseGamepad() {
	var gamepadAtivo = global.gamepadAtivo;
	
	if (gamepadAtivo) {
		var gamepad = obterGamepadAtivo();
		
		if (gamepad.start.pressed) {
			pausar();
		}
	}
}

function checagemComandosGamepad() {
	var gamepadAtivo = global.gamepadAtivo;
	
	if (gamepadAtivo) {
		var gamepad = obterGamepadAtivo();
		var samurai = global.propriedadesPlayer.samurai;
		var direcaoAnteriorAnalogico = global.direcaoAnalogico.Esquerdo;
		
		var analogicoParaDireita = (gamepad.analogicoEsqu.speed > 0 &&
									(gamepad.analogicoEsqu.direction >= 315 ||
									 gamepad.analogicoEsqu.direction <= 45));
		
		var analogicoParaCima = (gamepad.analogicoEsqu.speed > 0 &&
								 gamepad.analogicoEsqu.direction >= 45 &&
								 gamepad.analogicoEsqu.direction <= 135);
		
		var analogicoParaEsquerda = (gamepad.analogicoEsqu.speed > 0 &&
									gamepad.analogicoEsqu.direction >= 135 &&
									gamepad.analogicoEsqu.direction <= 225);
		
		var analogicoParaBaixo = (gamepad.analogicoEsqu.speed > 0 &&
								 gamepad.analogicoEsqu.direction >= 225 &&
								 gamepad.analogicoEsqu.direction <= 315);
		
		if(gamepad.esquerda.down || analogicoParaEsquerda) {
			checarMovimento(DirecaoEnum.Esquerda);
		} else if (gamepad.esquerda.up 
				|| (direcaoAnteriorAnalogico == DirecaoEnum.Esquerda && !analogicoParaEsquerda)) {
			global.propriedadesPlayer.parando = true;
		}
		
		if(gamepad.direita.down || analogicoParaDireita) {
			checarMovimento(DirecaoEnum.Direita);
		} else if (gamepad.direita.up 
				|| (direcaoAnteriorAnalogico == DirecaoEnum.Direita && !analogicoParaDireita)) {
			global.propriedadesPlayer.parando = true;
		}
		
		if(gamepad.baixo.down || analogicoParaBaixo) {
			global.propriedadesPlayer.abaixado = true;
		} else if (gamepad.baixo.up 
				|| (direcaoAnteriorAnalogico == DirecaoEnum.Baixo && !analogicoParaBaixo)) {
			global.propriedadesPlayer.abaixado = false;
		}
		
		if(gamepad.botaoY.pressed && samurai) {
			lancarShuriken();
		}
		
		if(gamepad.botaoY.down) {
			global.propriedadesPlayer.correndo = true;
		} else if (gamepad.botaoY.up) {
			global.propriedadesPlayer.correndo = false;
		}
		
		if(gamepad.botaoB.down) {
			reproduzirSFXPlayer(SFXEnum.Pular);
			aplicarGravidadePlayer(true);
		} else if (gamepad.botaoB.up) {
			global.propriedadesPlayer.caindo = true;
		}
		
		//Alterar direção analogico
		if(!analogicoParaDireita && !analogicoParaEsquerda && !analogicoParaCima && !analogicoParaBaixo) {
			global.direcaoAnalogico.Esquerdo = DirecaoEnum.Neutro;
		} else if (analogicoParaDireita) {
			global.direcaoAnalogico.Esquerdo = DirecaoEnum.Direita;
		} else if (analogicoParaEsquerda) {
			global.direcaoAnalogico.Esquerdo = DirecaoEnum.Esquerda;
		} else if (analogicoParaCima) {
			global.direcaoAnalogico.Esquerdo = DirecaoEnum.Cima;
		} else if (analogicoParaBaixo) {
			global.direcaoAnalogico.Esquerdo = DirecaoEnum.Baixo;
		}
	}
}
	
function checagemIniciarJogoGamepad() {
	var gamepadAtivo = global.gamepadAtivo;
	
	if (gamepadAtivo) {
		var gamepad = obterGamepadAtivo();
		
		if(gamepad.cima.pressed ||
		   gamepad.baixo.pressed ||
		   gamepad.esquerda.pressed ||
		   gamepad.direita.pressed ||
		   gamepad.analogicoDir.pressed ||
		   gamepad.analogicoEsqu.pressed ||
		   gamepad.start.pressed ||
		   gamepad.select.pressed ||
		   gamepad.botaoR1.pressed ||
		   gamepad.botaoR2.pressed ||
		   gamepad.botaoL1.pressed ||
		   gamepad.botaoL2.pressed ||
		   gamepad.botaoA.pressed ||
		   gamepad.botaoB.pressed ||
		   gamepad.botaoX.pressed ||
		   gamepad.botaoY.pressed ) {
			iniciarJogo();
		}		
	}
}
	
function gamepadDirecaoAmbigua() {
	var ambiguo = false;
	var gamepadAtivo = global.gamepadAtivo;
	
	if(gamepadAtivo) {		
		var gamepad = obterGamepadAtivo();		
		var direcaoAnalogico = global.direcaoAnalogico.Esquerdo;
		
		ambiguo = ((gamepad.esquerda.down && direcaoAnalogico == DirecaoEnum.Direita)
				|| (gamepad.direita.down && direcaoAnalogico == DirecaoEnum.Esquerda))
	}
	
	return ambiguo;
}