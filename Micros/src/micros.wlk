/** First Wollok example */
class Micro {
	
	var property cantPasajerosSentados
	var property cantPasajerosParados
	var property volumen
	
	const property pasajeros = []
	
	method subirA(empleado) {
		if(!self.hayLugar() || !empleado.quiereSubirA(self)) {
			throw new DomainException(message = "no puede subir al micro")
		}
		pasajeros.add(empleado)
	}
	
	method bajar(empleado) {
		if(!self.estaEmpleado(empleado)) {
			throw new DomainException(message = "no está el empleado en el micro")
		}
		
		pasajeros.remove(empleado)
		
	}
	
	method estaEmpleado(unEmpleado) = pasajeros.contains(unEmpleado)
	
	
	method hayLugar() = self.cantidadPasajeros() < self.capacidad()
	
	method cantidadPasajeros() =  pasajeros.size()
	
	method capacidad() = cantPasajerosSentados + cantPasajerosParados
	
	method puedeViajarSentado() =  self.cantidadPasajeros() < cantPasajerosSentados
	
	method lugaresLibres() = self.capacidad() - self.cantidadPasajeros()

}



class Empleado {
	
	var property personalidad
	method quiereSubirA(micro) = personalidad.quiereSubirA(micro)
	
	
	

}


object apurado {
	method quiereSubirA(_) = true
}


object clautrofobico {
	
	method quiereSubirA(micro) = micro.volumen() > 120
	
	
}
object fiaca {
	
	method quiereSubirA(micro) = micro.puedeviajarSentado()
}

class Moderado {
	
	var property cantLugaresLibres
	
	method quiereSubirA(micro) = cantLugaresLibres <= micro.lugaresLibres()
}