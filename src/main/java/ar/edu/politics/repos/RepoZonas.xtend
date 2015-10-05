package ar.edu.politics.repos

import ar.edu.politics.domain.Zona
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery

class RepoZonas extends RepoDefault<Zona> {

	static RepoZonas instance

	static def getInstance() {
		if (instance == null) {
			instance = new RepoZonas()
		}
		return instance
	}

	override getEntityType() {
		typeof(Zona)
	}
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Zona> query, Zona zona) {
		val camposPartido = query.from(entityType)
		if (zona.descripcion != null) {
			criteria.equal(camposPartido.get("descripcion"), zona.descripcion)
		}
	}

	def Zona searchById(Long id) {
		val entityManager = entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery
			val camposPartido = query.from(entityType)
			criteria.equal(camposPartido.get("id"), id)
			val result = entityManager.createQuery(query).resultList
				
			if (result.isEmpty) {
				null
			} else {
				result.head as Zona
			}
		} finally {
			entityManager.close
		}
	}
	
}







