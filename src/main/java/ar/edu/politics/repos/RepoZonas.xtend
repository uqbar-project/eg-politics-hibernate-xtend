package ar.edu.politics.repos

import ar.edu.politics.domain.Zona
import org.uqbar.commons.model.CollectionBasedRepo

class RepoZonas extends CollectionBasedRepo<Zona> {
	
	static RepoZonas instance
	
	static def getInstance() {
		if (instance === null) {
			instance = new RepoZonas()
		}
		return instance
	}
	
	override protected getCriterio(Zona example) {
		[ Zona zona | zona.descripcion.equalsIgnoreCase(example.descripcion) ]
	}
	
	override createExample() {
		new Zona
	}
	
	override getEntityType() {
		typeof(Zona)
	}
	
}