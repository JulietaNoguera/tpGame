import wollok.game.*

object utilidades {
	method posRandom() {
		return game.at(
			0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0)
		)
	}
}

