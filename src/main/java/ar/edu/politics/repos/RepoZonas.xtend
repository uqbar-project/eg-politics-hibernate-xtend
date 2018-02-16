package ar.edu.politics.repos

import ar.edu.politics.domain.Zona
import org.hibernate.Criteria
import org.hibernate.FetchMode
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions

class RepoZonas extends RepoDefault<Zona> {

	static RepoZonas instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoZonas()
		}
		return instance
	}
	
	override getEntityType() {
		typeof(Zona)
	}
	
	override addQueryByExample(Criteria criteria, Zona zona) {
		if (zona.descripcion !== null) {
			criteria.add(Restrictions.eq("descripcion", zona.descripcion))
		}
	}

	def Zona searchById(Long id) {
		val session = openSession
		try {
			session.createCriteria(Zona)
				.setFetchMode("candidatos", FetchMode.JOIN)
				.add(Restrictions.eq("id", id))
				.uniqueResult as Zona
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
}
