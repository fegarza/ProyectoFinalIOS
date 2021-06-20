//
//  ViewController.swift
//  Bonbon
//
//  Created by Felipe Garza on 13/06/21.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    @IBAction func IngresarAction(_ sender: Any) {
        if(defaults.bool(forKey: "sonido")){
            AudioServicesPlaySystemSound(SystemSoundID(1000))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

