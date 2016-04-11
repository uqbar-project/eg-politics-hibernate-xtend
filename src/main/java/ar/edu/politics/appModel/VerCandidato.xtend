package ar.edu.politics.appModel

import ar.edu.politics.domain.Candidato
import ar.edu.politics.repos.RepoCandidatos
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class VerCandidato {
	
	Candidato candidato
	String nuevaPromesa
	
	new(Candidato candidato) {
		this.candidato = RepoCandidatos.instance.get(candidato.id)
	}
	
	def void agregarPromesa() {
		candidato.agregarPromesa(nuevaPromesa)
		nuevaPromesa = ""
	}
	
	@Dependencies("nuevaPromesa")
	def boolean getPuedeAgregarPromesa() {
		nuevaPromesa != null && !nuevaPromesa.equals("")
	}
	
	def void actualizar() {
		RepoCandidatos.instance.update(candidato)
	}

}