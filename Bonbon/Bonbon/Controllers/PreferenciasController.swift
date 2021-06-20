//
//  PreferenciasController.swift
//  Bonbon
//
//  Created by Angel Mendez on 15/06/21.
//

import Foundation
import UIKit

class PreferenciasController : UIViewController{
    
    
    @IBOutlet weak var swVibracion: UISwitch!
    
    @IBOutlet var swSonido: UISwitch!

    @IBOutlet weak var textNombre: UITextField!
    
    let defaults = UserDefaults.standard
    
    
    @IBAction func modificarSonido(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "sonido")
        defaults.synchronize()
    }
    
    @IBAction func modificarVibracion(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "vibracion")
        defaults.synchronize()
    }
    
    override func viewDidLoad() {
        self.swSonido.isOn = defaults.bool(forKey: "sonido")
        self.swVibracion.isOn = defaults.bool(forKey: "vibracion")
        self.textNombre.text = defaults.string(forKey: "nombre")
    }
    @IBAction func cambiarNombre(_ sender: UITextField) {
        defaults.set(sender.text, forKey: "nombre")
        defaults.synchronize()
    }
}
