package ar.edu.politics.domain

import java.time.LocalDate
import javax.persistence.Column
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@Observable
@Accessors
@Entity
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoCandidato", discriminatorType=DiscriminatorType.INTEGER)
abstract class Partido {

	@Id
	@GeneratedValue
	private Long id
	
	@Column(length=150)
	String nombre
	
	@Column
	int afiliados
	
	def void validar() {
		if (nombre === null) {
			throw new UserException("Debe ingresar nombre")
		}
		if (afiliados < 1000) {
			throw new UserException("El partido no tiene suficientes afiliados")
		}
	}
	
	override toString() {
		nombre
	}
	
}

@Accessors
@Entity
@DiscriminatorValue("1")
class Peronista extends Partido {

	@Column	
	boolean populista = false
	
	new() {
		
	}
	
}

@Accessors
@Entity
@DiscriminatorValue("2")
class Preservativo extends Partido {

	@Column
	LocalDate fechaCreacion
	
	new() {
		
	}
	
	override validar() {
		super.validar()
		if (fechaCreacion === null) {
			throw new UserException("Debe ingresar fecha de creación")
		}
		if (fechaCreacion.compareTo(LocalDate.now) > 0) {
			throw new UserException("La fecha de creación debe ser anterior a la de hoy")
		}	
	}	

}