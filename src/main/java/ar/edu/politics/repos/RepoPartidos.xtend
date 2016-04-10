package ar.edu.politics.repos

import ar.edu.politics.domain.Partido
import org.uqbar.commons.model.CollectionBasedRepo

class RepoPartidos extends CollectionBasedRepo<Partido> {
	
	static RepoPartidos instance
	
	static def getInstance() {
		if (instance == null) {
			instance = new RepoPartidos()
		}
		return instance
	}
		
	override protected getCriterio(Partido example) {
		[ Partido partido | partido.nombre.equalsIgnoreCase(example.nombre) ]
	}
	
	override createExample() {
		new Partido
	}
	
	override getEntityType() {
		typeof(Partido)
	}
	
}