package ar.edu.politics.repos

import ar.edu.politics.domain.Candidato
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root

class RepoCandidatos extends RepoDefault<Candidato> {

	static RepoCandidatos instance
	
	static def getInstance() {
		if (instance === null) {
			instance = new RepoCandidatos()
		}
		return instance
	}
	
	override getEntityType() {
		typeof(Candidato)
	}
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Candidato> query, Root<Candidato> camposCandidato, Candidato candidato) {
		if (candidato.nombre !== null) {
			query.where(criteria.equal(camposCandidato.get("nombre"), candidato.nombre))
		} 
	}

	def Candidato get(Long id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(typeof(Candidato))
			val Root<Candidato> from = query.from(Candidato)
			from.fetch("promesas", JoinType.LEFT)
			query
				.select(from)
				.where(criteria.equal(from.get("id"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager.close
		}
	}

}