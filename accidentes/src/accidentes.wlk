class Vehiculo {
	
	var property poliza
	const property siniestros = []
	
	method cuantoCubrePolizaEn(siniestro) {
		return poliza.cuantoCubreEn(siniestro, self)
	}
	
	method pagosNoCubiertos() {
		return siniestros.sum({unSiniestro => poliza.montoNoCubierto(unSiniestro, self)})
	}
	
}


class Siniestro {
	
	const property danios = []
	
	method daniosPara(unVehiculo) {
		return self.danioPara(unVehiculo).monto()
	}
	
	method danioPara(unVehiculo){
		return danios.find({unDanio => unDanio.involucrado() == unVehiculo})
	}
	
}

class Danio {
	
	var property monto
	var property involucrado
}

class Poliza {
	var property aseguradora
	
	method cuantoCubreEn(unSiniestro, unVehiculo) {
		return self.danios(unSiniestro, unVehiculo).sum({unDanio => unDanio.monto()})
	}
	
	method danios(unSiniestro, unVehiculo)
}
class ContraTerceros inherits Poliza {

	override method danios(unSiniestro, unVehiculo) {
		return unSiniestro.danios().filter({unDanio => unDanio.involucrado()!= unVehiculo})
	}	
	
	method montoNoCubierto(unSiniestro, vehiculo) = unSiniestro.daniosPara(vehiculo)
}

class ContraTodoRiesgo inherits Poliza {
	
	override method danios(unSiniestro, _) = unSiniestro.danios()
	
	method montoNoCubierto(_, vehiculo) = 0	
	
}

class Aseguradora {
	method cuantoDebePagarPor(unSiniestro, unVehiculo) {
		self.validarSiEstaVehiculo(unSiniestro, unVehiculo)
		return unVehiculo.cuantoCubrePolizaEn(unSiniestro)		
	}
	
	
	method validarSiEstaVehiculo(unSiniestro, unVehiculo) {
		if (!unSiniestro.esta(unVehiculo)) {
			throw new NoParticipoVehiculo(message = "vehiculo no esta involucrado en el siniestro")
		}
	}
	
	
		
}
	
class NoParticipoVehiculo inherits DomainException {
}