package ar.edu.politics.repos

import ar.edu.politics.domain.Candidato
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery

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
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Candidato> query, Candidato candidato) {
		val camposCandidato = query.from(entityType)
		if (candidato.nombre != null) {
			query.where(criteria.equal(camposCandidato.get("nombre"), candidato.nombre))
		} 
	}

}