//
//  RecetaValidator.swift
//  Bonbon
//
//  Created by Felipe Garza on 19/06/21.
//

import Foundation

class RecetaValidator : Validatable{
    
    let receta : Receta
    
    init(receta: Receta){
        self.receta = receta
    }
    
    func isValid() -> Bool {
        if(receta.Nombre == nil || receta.Nombre!.isEmpty){
            return false;
        }
        if(receta.Categoria == nil || receta.Categoria!.isEmpty){
            return false
        }
        if(receta.Descripcion == nil || receta .Descripcion!.isEmpty){
            return false
        }
        if(receta.TiempoCoccion == nil || receta.TiempoCoccion!.isEmpty){
            return false
        }
        if(receta.Dificultad == nil || receta.Dificultad!.isEmpty){
            return false
        }
        return true;
    }
    
    func getErrors() -> [String] {
        var errores : [String] = []

        if(receta.Nombre == nil || receta.Nombre!.isEmpty){
            errores.append("hace falta introducir el nombre de la receta")
        }
        if(receta.Categoria == nil || receta.Categoria!.isEmpty){
            errores.append("no se ha seleccionado una categoria")
        }
        if(receta.Descripcion == nil || receta .Descripcion!.isEmpty){
            errores.append("no se ha dado una descripcion de la receta")
        }
        if(receta.TiempoCoccion == nil || receta.TiempoCoccion!.isEmpty){
            errores.append("no se ha introducido el tiempo de coccion")
        }
        if(receta.Dificultad == nil || receta.Dificultad!.isEmpty){
            errores.append("no se ha seleccionado una dificultad")
        }
        return errores;
       
    }
    
    func getErrors() -> String {
        var cadenaDeError = "Se han encontrado los siguientes errores:"
        
        for error : String in self.getErrors(){
            cadenaDeError = cadenaDeError + " \n" + " - " + error
        }
        return cadenaDeError
    }
    
    
}
