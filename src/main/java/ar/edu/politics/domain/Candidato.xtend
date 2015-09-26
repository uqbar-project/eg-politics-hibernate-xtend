package ar.edu.politics.domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Candidato extends Entity {
	
	String nombre
	Partido partido
	List<Promesa> promesas = newArrayList 
	
	new() {
		
	}
	
	def void validar() {
		if (nombre == null) {
			throw new UserException("Debe ingresar descripcion")
		}
		if (partido == null) {
			throw new UserException("El candidato debe estar participando en un partido político")
		}
	}
	
	override toString() {
		nombre
	}
	
	def agregarPromesa(String nuevaPromesa) {
		promesas.add(new Promesa(nuevaPromesa))
		ObservableUtils.firePropertyChanged(this, "promesas", promesas)
	}

}