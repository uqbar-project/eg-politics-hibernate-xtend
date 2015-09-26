package ar.edu.politics.ui

import ar.edu.politics.appModel.VerCandidato
import ar.edu.politics.domain.Promesa
import java.awt.Color
import java.text.SimpleDateFormat
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

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
			bindValueToProperty("candidato.nombre")
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
			bindValueToProperty("nuevaPromesa")
			width = 200
		]
		new Button(panelPromesaNueva) => [
			caption = "Agregar promesa"
			onClick [ | this.modelObject.agregarPromesa ]
			bindEnabledToProperty("puedeAgregarPromesa")
		]
		val gridPromesas = new Table(panelDerecho, typeof(Promesa)) => [
			bindItemsToProperty("candidato.promesas")
		]
		new Column<Promesa>(gridPromesas) => [
			title = "Fecha"
			fixedSize = 100
			bindContentsToTransformer [ Promesa promesa | new SimpleDateFormat("dd/MM/yyyy").format(promesa.fecha) ] 
		]
		new Column<Promesa>(gridPromesas) => [
			title = "Promesa"
			fixedSize = 500
			bindContentsToProperty("accionPrometida")
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