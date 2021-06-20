//
//  UIViewControllerExtension.swift
//  Bonbon
//
//  Created by Felipe Garza on 18/06/21.
//

import Foundation

import UIKit
import AVFoundation
import AudioToolbox



extension UIViewController{
    func present(controlador: UIAlertController, tipo: UIAlertController.BonbonAlertType){
        let defaults = UserDefaults.standard
        
        switch(tipo){
        case UIAlertController.BonbonAlertType.confirmar:
            if(defaults.bool(forKey: "vibracion")){
                AudioServicesPlaySystemSound(SystemSoundID(4095))
            }
        case UIAlertController.BonbonAlertType.error:
            if(defaults.bool(forKey: "vibracion")){
                AudioServicesPlaySystemSound(SystemSoundID(4095))
            }
            if(defaults.bool(forKey: "sonido")){
                AudioServicesPlaySystemSound(SystemSoundID(1073))
            }
            if(defaults.bool(forKey: "sonido")){
                AudioServicesPlaySystemSound(SystemSoundID(1000))
            }
        case UIAlertController.BonbonAlertType.informativo:
            if(defaults.bool(forKey: "sonido")){
                AudioServicesPlaySystemSound(SystemSoundID(1000))
            }
        }
        
        self.present(controlador, animated: true);
    }
}
