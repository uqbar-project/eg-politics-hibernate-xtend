package ar.edu.politics.repos

import ar.edu.politics.domain.Candidato
import ar.edu.politics.domain.Partido
import ar.edu.politics.domain.Peronista
import ar.edu.politics.domain.Preservativo
import ar.edu.politics.domain.Promesa
import ar.edu.politics.domain.Zona
import java.util.List
import org.hibernate.Criteria
import org.hibernate.HibernateException
import org.hibernate.SessionFactory
import org.hibernate.cfg.Configuration

abstract class RepoDefault<T> {
	
	protected static final SessionFactory sessionFactory = new Configuration().configure()
		.addAnnotatedClass(Zona)
		.addAnnotatedClass(Candidato)
		.addAnnotatedClass(Promesa)
		.addAnnotatedClass(Partido)
		.addAnnotatedClass(Peronista)
		.addAnnotatedClass(Preservativo)
		.buildSessionFactory()

	def List<T> allInstances() {
		val session = sessionFactory.openSession
		try {
			return session.createCriteria(getEntityType).list()
		} finally {
			session.close
		}
	}
	
	def List<T> searchByExample(T t) {
		val session = sessionFactory.openSession
		try {
			val criteria = session.createCriteria(getEntityType)
			this.addQueryByExample(criteria, t)
			return criteria.list()
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def void create(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.save(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def void update(T t) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.update(t)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	def abstract Class<T> getEntityType()

	def abstract void addQueryByExample(Criteria criteria, T t)

	def openSession() {
		sessionFactory.openSession
	}
	
}