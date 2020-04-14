package ar.edu.politics.repos

import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

abstract class AbstractRepo<T> {

	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Politics")

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}

	def allInstances() {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			val result = entityManager.createQuery(query).resultList
			result
		} finally {
			entityManager?.close
		}
	}

	def searchByExample(T t) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)

			this.addQueryByExample(t, criteria, query, from)

			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}
	
	def void addQueryByExample(T t, CriteriaBuilder builder, CriteriaQuery<T> query, Root<T> from)

	def Class<T> entityType()
	
	def create(T t) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				// ahora soy transient
				persist(t)
				transaction.commit
				// ahora persistent
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager.close
			// ahora soy detached
		}
	}

	def update(T t) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				merge(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}

}