package ar.edu.politics.repos

import java.util.List
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery

abstract class RepoDefault<T> {
	
	private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Politics")
	 
	def List<T> allInstances() {
		val entityManager = this.entityManager
		try {
			val query = entityManager.criteriaBuilder.createQuery(entityType)
			return entityManager.createQuery(query).resultList as List<T> 
		} finally {
			entityManager.close
		}
	}
	
	abstract def Class<T> getEntityType()

	def searchByExample(T t) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery as CriteriaQuery<T>
			val from = query.from(entityType)
			query.select(from)
			generateWhere(criteria, query, t)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}
	
	abstract def void generateWhere(CriteriaBuilder criteria, CriteriaQuery<T> query, T t)
	
	def saveOrUpdate(T t) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				persist(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			//entityManager.transaction.rollback
			throw new RuntimeException("AH, Ha ocurrido un error. JAJAJAJA", e)
		} finally {
			entityManager.close
		}
	}

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}
	
}