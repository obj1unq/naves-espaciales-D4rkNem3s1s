class Nave{
	var property velocidad

	method recibirAmenaza(){}

	method propulsar() {
		velocidad = 300000.min(velocidad + 20000)
	}

	method prepararViaje(){
		velocidad = 300000.min(velocidad + 15000)
	}

	method encontrarEnemigo(){
		self.recibirAmenaza()
	}
}
class NaveDeCarga inherits Nave{

	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}

}

class NaveCargaResiduosRadiactivos inherits NaveDeCarga{
	var property sellado = false

	method sellarAlVacio(){
		sellado = true
	}

	override method recibirAmenaza(){
		self.velocidad(0)
	}

	override method prepararViaje() {
		velocidad = 300000.min(velocidad + 15000)
		self.sellarAlVacio()
	}
}



class NaveDePasajeros inherits Nave{

	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate inherits Nave{
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	override method prepararViaje(){
		velocidad = 300000.min(velocidad + 15000)
		if(modo == reposo){
			self.error("Saliendo en misión")
		}else{
			self.error("Volviendo a la base")
		}
	}

}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

}
