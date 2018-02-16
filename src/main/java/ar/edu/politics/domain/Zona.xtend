package ar.edu.politics.domain

import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
@Accessors
class Zona extends Entity {
	
	String descripcion
	Set<Candidato> candidatos = newHashSet
		
	new() {
		
	}
	
	def void validar() {
		if (descripcion === null) {
			throw new UserException("Debe ingresar descripcion")
		}
		if (candidatos.isEmpty) {
			throw new UserException("Debe haber al menos un candidato en la zona")
		}
	}
	
	override toString() {
		descripcion
	}
	
}
