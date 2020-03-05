package ar.edu.politics.ui

import ar.edu.politics.appModel.ConsultaCandidatos
import ar.edu.politics.appModel.VerCandidato
import ar.edu.politics.domain.Candidato
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class ConsultaCandidatosWindow extends SimpleWindow<ConsultaCandidatos> {
	
	new(WindowOwner parent) {
		super(parent, new ConsultaCandidatos)
	}
	
	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Ver ficha"
			enabled <=> "puedeVerFicha"
			onClick [ | 
				val candidatoSeleccionado = this.modelObject.candidatoSeleccionado
				new VerCandidatoDialog(this, new VerCandidato(candidatoSeleccionado)).open ]
		]
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Consulta de candidatos"
		
		new Label(mainPanel).text = "Zona de votación"
		new Selector(mainPanel) => [
			allowNull = false
			items <=> "zonasDeVotacion"
			value <=> "zonaSeleccionada"
		]
		
		new Label(mainPanel).text = "Candidatos"
		val gridCandidatos = new Table(mainPanel, Candidato) => [
			items <=> "zonaSeleccionada.candidatos"
			value <=> "candidatoSeleccionado"
			numberVisibleRows = 5
		]
		
		// Columnas
		new Column<Candidato>(gridCandidatos) => [
			title = "Candidato"
			bindContentsToProperty("nombre")
			fixedSize = 200
		]
		new Column<Candidato>(gridCandidatos) => [
			title = "Partido"
			bindContentsToProperty("partido")
			fixedSize = 300
		]
	}
	
}