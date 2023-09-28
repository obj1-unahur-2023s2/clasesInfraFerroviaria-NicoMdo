import vagones.*
import locomotora.*

class Formacion {
	const vagones = new List()
	const locomotoras = new List()
	
	method agregarVagon(unVagon){
		vagones.add(unVagon)
	}
	
	method agregarLocomotora(unaLocomotora){
		locomotoras.add(unaLocomotora)
	}
	
	method desarmarFormacion(){
		vagones.clear()
	}
	
	method cuantosPasajerosPuedeLLevar() {
		return vagones.sum {vagon => vagon.cantidadDePasajeros()}
	}
	
	method cantidadVagonesPopulares() {
		return vagones.count { vagon => vagon.esPopular()}
	}
	
	method realizarMantenimientoVagones() {
		vagones.forEach { vagon => vagon.recibirMantenimiento()}
	}
	
	method esFormacionCarguera() {
		return vagones.all  { vagon => vagon.puedeTransportar(1000)}
	}
	
	method dispersionDePesos() {
		const maximo = vagones.max { vagon => vagon.pesoMaximo() }
		const minimo = vagones.min { vagon => vagon.pesoMaximo() }
		return maximo.pesoMaximo() - minimo.pesoMaximo()
	}
	
	method cantidDeBanios() {
		return vagones.count { vagon => vagon.tieneBanio()}
	}
	
	method estaEquilibrada() {
		const pasajeros =self.vagonesSoloDePasajeros() 
		const maximo = pasajeros.max {vagon => vagon.cantidadDePasajeros() }
		const minimo = pasajeros.min {vagon => vagon.cantidadDePasajeros() }
		return maximo.cantidadDePasajeros() - minimo.cantidadDePasajeros() <= 20
	}
	
	method vagonesSoloDePasajeros() {
		return vagones.filter { vagon => vagon.esDePasajeros()}
	}
	
	method estaOrganizada() {
		return not (1..vagones.size()-1).any {
			indice => not vagones.get(indice-1).esDePasajeros() and vagones.get(indice).esDePasajeros()
		}
	}
	
	method velocidadMax(){
		return locomotoras.min{p => p.velocidadMax()}.velocidadMax()
	}
	
	method esEficiente(){
		return locomotoras.all({p=> p.esEficiente()})
	}
	
	method capacidadArrastreDeLocomotoras(){
		return locomotoras.sum({p=> p.capacidadDeArrastre()})
	}
	
	method pesoLocomotoras(){
		return locomotoras.sum({p=> p.peso()})
	}
	
	method pesoMaximoDeVagones(){
		return vagones.sum({p=> p.pesoMaximo()})
	}
	
	method pesoMaximo(){
		return self.pesoLocomotoras() + self.pesoMaximoDeVagones()
	}
	
	method puedeMoverse(){
		return self.capacidadArrastreDeLocomotoras() >= self.pesoMaximo()
	}
	
	method cuantosKgFaltanParaMoverse()= if(self.puedeMoverse()){0}else{self.pesoMaximo() - self.capacidadArrastreDeLocomotoras()}
	
	method vagonMasPesado() {
		return vagones.max { vagon => vagon.pesoMaximo()}
	}
	
	method esCompleja(){
		return (vagones.size() + locomotoras.size()) > 8 or self.pesoMaximo() > 80000
	}
	
}