package ar.edu.politics.application

import ar.edu.politics.ui.ConsultaCandidatosWindow
import org.uqbar.arena.Application

class PoliticsApplication extends Application {

	new(PoliticsBootstrap bootstrap) {
		super(bootstrap)
	}
	
	override protected createMainWindow() {
		new ConsultaCandidatosWindow(this)
	}

	static def void main(String[] args) {
		new PoliticsApplication(new PoliticsBootstrap).start()
	}

}
