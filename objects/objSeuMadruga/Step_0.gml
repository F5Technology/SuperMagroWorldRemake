checagemComandosGamepad();
adicionarHitBoxInferior();
aplicarGravidadePlayer(false);
finalizarAnimacaoLancarShuriken();

if (global.propriedadesPlayer.parando) {
	movimentar(global.propriedadesPlayer.direcao);
}

