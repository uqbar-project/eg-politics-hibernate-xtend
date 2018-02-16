package ar.edu.politics.domain

import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
@Accessors
class Partido extends Entity {
	
	String nombre
	int afiliados
	
	def void validar() {
		if (nombre === null) {
			throw new UserException("Debe ingresar nombre")
		}
		if (afiliados < 1000) {
			throw new UserException("El partido no tiene suficientes afiliados")
		}
	}
	
	override toString() {
		nombre
	}
	
}

@Accessors
class Peronista extends Partido {
	
	boolean populista
	
	new() {
		
	}
	
}

@Accessors
class Preservativo extends Partido {

	LocalDate fechaCreacion
	
	new() {
		
	}
	
	override validar() {
		super.validar()
		if (fechaCreacion === null) {
			throw new UserException("Debe ingresar fecha de creación")
		}
		if (fechaCreacion.compareTo(LocalDate.now) > 0) {
			throw new UserException("La fecha de creación debe ser anterior a la de hoy")
		}	
	}	

}