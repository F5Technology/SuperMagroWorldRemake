/// @description Enums

enum DirecaoEnum {
	Baixo = -2,
	Esquerda = -1,
	Neutro = 0,
	Direita = 1,
	Cima = 2
}

enum ElevacaoEnum {
	Subir = -1,
	Descer = 1
}

enum TipoColisaoEnum {
	Vertical = 1,
	Horizontal = 2
}

enum SpriteEnum {
	Parado = 1,
	Andando = 2,
	Correndo = 3,
	Abaixado = 4,
	Pulando = 5,
	Caindo = 6,
	Derrapando = 7,
	LancarProjetil = 8,
	Morrendo = 9,
	Aparecendo = 10,
	Escondendo = 11,
	CoolDown = 12
}

enum ValorEnum {
	Vida = 1,
	Ponto10 = 10,
	Ponto200 = 200,
	Ponto400 = 400,
	Ponto1000 = 1000
}

enum SituacaoChefeEnum {
	Ativo = 1,
	Aterrissando = 2,
	ConcluirAterrisagem = 3,
	SumonandoInimigos = 4,
	CoolDown = 5,
	Atacando = 6
}

enum SFXEnum {
	Pular = 1,
	TransformarSamurai = 2,
	TransformarNormal = 3,
	DispararShuriken = 4,
	Moeda = 5,
	QuebrarTijolos = 6, 
	BlocoInterrogacao = 7,
	DanoShuriken = 8,
	Tremer = 9,
	SumonarInimigos = 10,
	BaterTeto = 11
}