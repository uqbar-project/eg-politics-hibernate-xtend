package ar.edu.politics.appModel

import ar.edu.politics.domain.Candidato
import ar.edu.politics.domain.Zona
import ar.edu.politics.repos.RepoZonas
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class ConsultaCandidatos {

	List<Zona> zonasDeVotacion	
	Zona zonaSeleccionada
	Candidato candidatoSeleccionado
	
	new() {
		zonasDeVotacion = RepoZonas.instance.allInstances
		setZonaSeleccionada = zonasDeVotacion.head
	}
	
	@Dependencies("candidatoSeleccionado")
	def boolean getPuedeVerFicha() {
		candidatoSeleccionado !== null
	}

	def void setZonaSeleccionada(Zona zona) {
		zonaSeleccionada = RepoZonas.instance.searchById(zona.id)	
	}
		
}