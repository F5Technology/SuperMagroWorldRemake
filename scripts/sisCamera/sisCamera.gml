/// @description Mecanicas da camera

function acompanharPlayer(){
	var morto = global.propriedadesPlayer.morto;
	
	if(!morto) {
		var posicaoHorizontal = global.propriedadesPlayer.direcao == DirecaoEnum.Direita ? 
		objSeuMadruga.x + 15 : 
		objSeuMadruga.x;
	
		y = lerp(y, objSeuMadruga.y, 0.10);
		x = lerp(x, posicaoHorizontal, 0.10);
	}
}