import wollok.game.*
import fondo.*
import personaje.*
import elementos.*
import nivel2.*
import marcador.*
import direcciones.*
import deposito.*
import consumibles.*
import inicio.*
import celdaSorpresa.*


object nivelBloques {

	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image= "fondo.png"))
		
		//DEPOSITO
		const desposito1  = [new Position(x=7, y=12), new Position(x=8, y=12),new Position(x=7, y=11), new Position(x=8, y=11),new Position(x=7, y=13),new Position(x=8, y=13)]
			.map{ p => self.dibujar(new Deposito(image="almacenaje2.png",position = p)) }
		
			
			
		//	estrellas
		const estrellas = [new Position(x=2, y=5), new Position(x=7, y=3), new Position(x=11, y=13), new Position(x=12, y=7)]
			.map{ p => self.dibujar(new Estrella(image = "estrella.png",position = p, llegadas = desposito1)) }
			
		// Llaves
		const llaves = [new Position(x=8, y=5), new Position(x=9, y=10)]
			.map{ p => self.dibujar(new Estrella(image = "llave1.png",position = p, llegadas = desposito1)) }
		
		
		//CONSUMIBLES
		
		// hamburguesas
		
		const hamburguesas = [new Position(x=1, y=8), new Position(x=2, y=1), new Position(x=10, y=7), new Position(x=13, y=12), new Position(x=2, y=13)]
			.map{ p => self.dibujar(new Energia(image = "hamburger.png",position = p, aporta = 10)) }
			
		const botiquin= [new Position(x=4, y=2), new Position(x=13, y=5), new Position(x=5, y=13), new Position(x=11, y=1)]
			.map{ p => self.dibujar(new Salud(image = "botiquin.png",position = p, aporta = 5)) }
		
		
		
		game.addVisual(salud)
		game.addVisual(saludNum)
		game.addVisual(energia)
		game.addVisual(energiaNum)
		game.addVisual(dinero)
		game.addVisual(dineroNum)
		
		//celdas sorpresas 
		const celdaElementorRnd = new CeldaElementoRandom(image = 'pregunta.png',position = game.at(5,5),puntos=0)
		const celdaTeleport = new CeldaTeleport(image = 'pregunta.png',position = game.at(5,10),puntos=0)
		
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(bubba)
		
		
		
		// teclado
		// este es para probar, no es necesario dejarlo
		keyboard.t().onPressDo({ self.terminar() })
		
		// Movimientos
		keyboard.up().onPressDo({ bubba.direccion(arriba) bubba.avanzar() })
		keyboard.down().onPressDo({ bubba.direccion(abajo) bubba.avanzar() })
		keyboard.left().onPressDo({ bubba.direccion(izquierda) bubba.avanzar() })
		keyboard.right().onPressDo({ bubba.direccion(derecha) bubba.avanzar() })
		keyboard.space().onPressDo({ bubba.comer()})		
		keyboard.any().onPressDo{ self.comprobarSiGano(estrellas, llaves) }
		
		// en este no hacen falta colisiones
		game.whenCollideDo(bubba, { elemento => bubba.empujar(elemento)})
		
		
	//CELDA SORPRESA:
		const celdasSorpresas = [celdaElementorRnd,celdaTeleport]
		game.addVisual(celdaTeleport)
		celdasSorpresas.forEach{ e => game.whenCollideDo(e,{player => if(player.puedeRecibirDanio()){e.afectar(player)}})}
		
			
		game.addVisual(desposito1)
		game.addVisual(estrellas)
		game.addVisual(llaves)
		game.addVisual(hamburguesas)
		game.addVisual(botiquin)
	}	
		
		
	method dibujar(dibujo) {
		game.addVisual(dibujo)
		return dibujo
	}
	method comprobarSiGano(elem1,elem2) {
		if (elem1.all{ c => c.estaBienPosicionada() } and elem2.all{ c => c.estaBienPosicionada() }) {
			self.ganar() 
		}
	}
	method ganar(){
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(position = game.at(0,0),image="ganador.png"))
		
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="nivel2.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				nivelLlaves.configurate()
			})
		})
		
	}
	
	
	method perder(){
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(position = game.at(0,0),image="gameover.png"))
		// después de un ratito ...
		game.schedule(2500, {
			// cambio de fondo
			game.addVisual(new Fondo(image="niveles1.png"))
			
			// después de un ratito ...
			
			niveles.configurate()
			   
			
		})
	}
	
	
	method terminar() {
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image="fondo.png"))
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="nivel2.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				// y arranco el siguiente nivel
				nivelLlaves.configurate()
			})
		})
	}
		
}
