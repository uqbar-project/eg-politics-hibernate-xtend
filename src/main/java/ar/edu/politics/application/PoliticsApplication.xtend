package ar.edu.politics.application

import org.uqbar.arena.Application
import ar.edu.politics.repos.JuegoDeDatos
import ar.edu.politics.ui.ConsultaCandidatosWindow

class PoliticsApplication extends Application {

	override protected createMainWindow() {
		new ConsultaCandidatosWindow(this)
	}

	static def void main(String[] args) {
		new JuegoDeDatos().init
		new PoliticsApplication().start()
	}

}
