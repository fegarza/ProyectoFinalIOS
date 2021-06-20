//
//  Validatable.swift
//  Bonbon
//
//  Created by Felipe Garza on 19/06/21.
//

import Foundation

protocol Validatable {
    
    func isValid() -> Bool
    
    func getErrors() -> [String]
    
    func getErrors() -> String
    
}
