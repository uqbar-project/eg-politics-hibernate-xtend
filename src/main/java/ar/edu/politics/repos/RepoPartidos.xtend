package ar.edu.politics.repos

import ar.edu.politics.domain.Partido
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery

class RepoPartidos extends RepoDefault<Partido> {

	static RepoPartidos instance

	static def getInstance() {
		if (instance == null) {
			instance = new RepoPartidos()
		}
		return instance
	}

	override getEntityType() {
		typeof(Partido)
	}

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Partido> query, Partido partido) {
		val camposPartido = query.from(entityType)
		if (partido.nombre != null) {
			criteria.equal(camposPartido.get("nombre"), partido.nombre)
		}
	}

}
