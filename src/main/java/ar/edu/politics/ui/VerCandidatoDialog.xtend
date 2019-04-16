package ar.edu.politics.ui

import ar.edu.politics.appModel.VerCandidato
import ar.edu.politics.domain.Promesa
import java.awt.Color
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.List

class VerCandidatoDialog extends Dialog<VerCandidato> {
	
	new(WindowOwner owner, VerCandidato model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Ver ficha de Candidato"
		mainPanel.layout = new HorizontalLayout
		
		val panelIzquierdo = new Panel(mainPanel)
		new Label(panelIzquierdo) => [
			text = "Candidato"
			foreground = Color.DARK_GRAY
		]
		new Label(panelIzquierdo) => [
			value <=> "candidato.nombre"
			background = Color.LIGHT_GRAY
			fontSize = 12
		]
		
		val panelDerecho = new Panel(mainPanel)

		new Label(panelDerecho) => [
			text = "Promesas"
			foreground = Color.DARK_GRAY
		]

		val panelPromesaNueva = new Panel(panelDerecho)
		panelPromesaNueva.layout = new HorizontalLayout
		new TextBox(panelPromesaNueva) => [
			value <=> "nuevaPromesa"
			width = 400
		]
		new Button(panelPromesaNueva) => [
			caption = "Agregar promesa"
			onClick [ | this.modelObject.agregarPromesa ]
			enabled <=> "puedeAgregarPromesa"
		]
		val gridPromesas = new Table(panelDerecho, Promesa) => [
			items <=> "candidato.promesas"
			numberVisibleRows = 5
		]
		// Columnas de la tabla de promesas
		new Column<Promesa>(gridPromesas) => [
			title = "Fecha"
			fixedSize = 100
			bindContentsToProperty("fecha").setTransformer = [ LocalDate fecha | fecha.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))
			] 
		]
		new Column<Promesa>(gridPromesas) => [
			title = "Promesa"
			fixedSize = 500
			bindContentsToProperty("accionPrometida")
		]

		// Opiniones		
		new Label(panelDerecho) => [
			text = "Opiniones"
			foreground = Color.DARK_GRAY
		]
		new List(panelDerecho) => [
			items <=> "candidato.opiniones"
			height = 300
		]
		val panelOpinionNueva = new Panel(panelDerecho)
		panelOpinionNueva.layout = new HorizontalLayout
		new TextBox(panelOpinionNueva) => [
			width = 400
			value <=> "nuevaOpinion"
		]
		new Button(panelOpinionNueva) => [
			caption = "Agregar opinión"
			onClick [ | this.modelObject.agregarOpinion ]
			enabled <=> "puedeAgregarOpinion"
		]

		new Button(panelDerecho) => [
			caption = "Actualizar Candidato"
			onClick [ | 
				this.modelObject.actualizar 
				this.close
			]
		]
		
	}
	
}