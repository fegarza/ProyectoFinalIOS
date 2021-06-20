//
//  Receta.swift
//  Bonbon
//
//  Created by Jessica Grajeda on 13/06/21.
//

import Foundation

struct Receta : Decodable{
    let RecetaID: Int?
    var Nombre: String?
    var Descripcion: String?
    var Dificultad: String?
    var TiempoCoccion: String?
    var Categoria: String?
    var NUsuario: String?
}
