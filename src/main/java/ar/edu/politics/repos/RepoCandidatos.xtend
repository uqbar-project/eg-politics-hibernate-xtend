package ar.edu.politics.repos

import ar.edu.politics.domain.Candidato
import org.uqbar.commons.model.CollectionBasedHome

class RepoCandidatos extends CollectionBasedHome<Candidato> {

	static RepoCandidatos instance
	
	static def getInstance() {
		if (instance == null) {
			instance = new RepoCandidatos()
		}
		return instance
	}
		
	override protected getCriterio(Candidato example) {
		[ Candidato candidato | candidato.nombre.equals(example.nombre)]
	}
	
	override createExample() {
		new Candidato
	}
	
	override getEntityType() {
		typeof(Candidato)
	}
	
}