/// @description Mecanicas da camera

function acompanharPlayer(){
	var morto = global.propriedadesPlayer.morto;
	var transformando = global.propriedadesPlayer.transformando;
	
	if(!morto && !transformando) {
		var direcao = global.propriedadesPlayer.direcao;
		var samurai = global.propriedadesPlayer.samurai;
		var player = samurai ? objSamurai : objSeuMadruga;		
		var posicaoHorizontal = direcao == DirecaoEnum.Direita ? player.x + 15 : player.x;
	
		y = lerp(y, player.y, 0.10);
		x = lerp(x, posicaoHorizontal, 0.10);
	}
}