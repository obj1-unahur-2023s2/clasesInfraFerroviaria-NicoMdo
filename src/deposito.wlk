import vagones.*
import locomotora.*
import formacion.*


class Deposito {
	const property formaciones = new List()
	const property locomotoras = new List()
	
	method agregarFormacion(unaFormacion){
		formaciones.add(unaFormacion)
	}
	
	method agregarLocomotora(unaLocomotora){
		locomotoras.add(unaLocomotora)
	}
	
	method vagonesMasPesados(){
		return formaciones.map({form=> form.vagonMasPesado()}).asSet()
	}
	
	method necesitaConductorExp(){
		return formaciones.any({form=> form.esCompleja()})
	}
	
	method locomotoraCapazDeMover(kg){
		return locomotoras.findOrDefault({loc=> loc.capacidadDeArrastre() >= loc.peso() + kg }, null)
	}
	
	method agregarLocomotoraA(formacion){
		if (not formacion.puedeMoverse()){	
			const kilosFaltantes = formacion.cuantosKgFaltanParaMoverse()
			const locomotoraDisponible = self.locomotoraCapazDeMover(kilosFaltantes)
		
			if (locomotoraDisponible != null){
			formacion.agregarLocomotora(locomotoraDisponible)
			locomotoras.remove(locomotoraDisponible)
			}
		}
	}
	
	
}
