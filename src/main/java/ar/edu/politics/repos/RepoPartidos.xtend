package ar.edu.politics.repos

import ar.edu.politics.domain.Partido
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

class RepoPartidos extends RepoDefault<Partido> {
	
	static RepoPartidos instance
	
	static def getInstance() {
		if (instance === null) {
			instance = new RepoPartidos()
		}
		return instance
	}

	override getEntityType() {
		typeof(Partido)
	}

	override addQueryByExample(Criteria criteria, Partido partido) {
		if (partido.nombre !== null) {
			criteria.add(Restrictions.eq("nombre", partido.nombre))
		}
	}
	
}