package ar.edu.politics.domain

import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Promesa {
	
	LocalDate fecha
	String accionPrometida
	
	new() {
		
	}
	
	new(String accionPrometida) {
		fecha = LocalDate.now
		this.accionPrometida = accionPrometida
	}
	
	def void validar() {
		if (fecha == null) {
			throw new UserException("Debe ingresar fecha")
		}
		if (accionPrometida == null) {
			throw new UserException("Debe ingresar una acción en la promesa")
		}
	}
	
}