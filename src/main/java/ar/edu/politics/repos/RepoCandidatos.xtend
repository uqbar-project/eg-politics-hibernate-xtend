package ar.edu.politics.repos

import ar.edu.politics.domain.Candidato
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

class RepoCandidatos extends RepoDefault<Candidato> {

	static RepoCandidatos instance
	
	static def getInstance() {
		if (instance == null) {
			instance = new RepoCandidatos()
		}
		return instance
	}
		
	override getEntityType() {
		typeof(Candidato)
	}

	override addQueryByExample(Criteria criteria, Candidato candidato) {
		if (candidato.nombre != null) {
			criteria.add(Restrictions.eq("nombre", candidato.nombre))
		}
	}
	
}