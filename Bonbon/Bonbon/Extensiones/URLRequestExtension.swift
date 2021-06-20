//
//  URLRequestExtension.swift
//  Bonbon
//
//  Created by Felipe Garza on 18/06/21.
//

import Foundation

extension URLRequest{
    
    init(endpoint: String, operacion: Operacion, receta: Receta?) throws {
       
        guard let url = URL(string: endpoint + "?operacion=\(String(operacion.rawValue))") else{
            throw ErrorManager.runtimeError("No se ha logrado crear la instancia de URL")
        }
        
        self.init(url: url)
        
        if(operacion == Operacion.consulta && receta == nil){
            self.httpMethod = "GET"
        }else{
            self.httpMethod = "POST"
        }
        
        self.httpBody = self.obtenerParametros(operacion: operacion, receta: receta).data(using: .utf8)
    }
    
    private func obtenerParametros(operacion: Operacion, receta: Receta?) -> String{
        if(receta == nil){
            return "";
        }
        
        var cadenaDeParametros = ""
        
        switch operacion{
            case Operacion.alta, Operacion.edicion:
                cadenaDeParametros =  "Nombre=\(receta!.Nombre!)&Descripcion=\(receta!.Descripcion!)&Dificultad=\(receta!.Dificultad!)&TiempoCoccion=\(receta!.TiempoCoccion!)&Categoria=\(receta!.Categoria!)"
                if(operacion == Operacion.edicion){
                    cadenaDeParametros += "&RecetaID="+String(receta!.RecetaID!)
                }
            case Operacion.baja, Operacion.consulta:
                if(receta?.RecetaID != nil){
                    cadenaDeParametros = "RecetaID="+String(receta!.RecetaID!)
                }
        }
        
        return cadenaDeParametros
    }
    
}
