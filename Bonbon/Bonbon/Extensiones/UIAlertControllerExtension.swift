//
//  UIAlertControllerExtension.swift
//  Bonbon
//
//  Created by Felipe Garza on 18/06/21.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox

extension UIAlertController{
        
    public enum BonbonAlertType: String{
        case confirmar = "Confirmar"
        case error = "Ha ocurrido un error!"
        case informativo = "Aviso"
    }
    
    public static func generarAcciones(bonbonTipo: BonbonAlertType,  handler: ((UIAlertAction) -> Void)? = nil) -> [UIAlertAction]{
        
        var acciones : [UIAlertAction] = []
        
        switch bonbonTipo{
        case BonbonAlertType.confirmar:
            acciones.append(UIAlertAction(title:"Cancelar", style: .cancel, handler: nil))
            acciones.append(UIAlertAction(title:"Confirmar", style: .default, handler: handler!))
            return acciones
        case BonbonAlertType.error:
            acciones.append(UIAlertAction(title:"Aceptar", style: .destructive, handler: nil))
            return acciones
        case BonbonAlertType.informativo:
            acciones.append(UIAlertAction(title:"OK", style: .default, handler: nil))
            return acciones
        }
        
    }
    
    convenience init(bonbonTipo: BonbonAlertType, mensaje: String, handler: ((UIAlertAction) -> Void)? = nil){
    self.init(title: String(bonbonTipo.rawValue), message: mensaje, preferredStyle: .alert, acciones: UIAlertController.generarAcciones(bonbonTipo: (bonbonTipo), handler: handler))
    }
    
    convenience init(title: String, message: String, preferredStyle: UIAlertController.Style , acciones: [UIAlertAction] ){
        let defaults = UserDefaults.standard
        
        var mensajeCompleto =   message
        let nombre = defaults.string(forKey: "nombre");
        
        if nombre != nil && !nombre!.isEmpty {
            mensajeCompleto = nombre! + ", " + mensajeCompleto.lowercased()
        }
        
        self.init(title: title, message: mensajeCompleto, preferredStyle: preferredStyle)
        
        for accionActual : UIAlertAction in acciones{
            self.addAction(accionActual);
        }
    }
}
