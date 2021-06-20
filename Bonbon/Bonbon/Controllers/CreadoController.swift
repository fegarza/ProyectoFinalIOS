//
//  CreadoController.swift
//  Bonbon
//
//  Created by Jessica Grajeda on 13/06/21.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox


class CreadoController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nombreRecetaText: UITextField!
    @IBOutlet weak var procedimientoText: UITextField!
    @IBOutlet weak var dificultadControl: UISegmentedControl!
    @IBOutlet weak var tiempoCoccionText: UITextField!
    @IBOutlet weak var categoriaPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reiniciarFormulario()
        
        self.categoriaPicker.delegate = self
        self.categoriaPicker.dataSource = self
        self.tiempoCoccionText.delegate = self
        self.procedimientoText.delegate = self
        self.nombreRecetaText.delegate = self
        
        self.tiempoCoccionText.addDoneButtonToKeyboard(myAction:  #selector(self.tiempoCoccionText.resignFirstResponder));
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Categoria.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: Categoria.allCases[row])
    }
    
    @IBAction func crearRecetaAction(_ sender: Any) {
        let recetaNueva = traerReceta()
        
        let validator = RecetaValidator(receta: recetaNueva);
        
        if(validator.isValid()){
            self.crearReceta(recetaNueva: recetaNueva)
        }else{
            self.present(controlador: UIAlertController(bonbonTipo: .error, mensaje: validator.getErrors()), tipo: UIAlertController.BonbonAlertType.error)
        }
    }
    
    func traerReceta() -> Receta{
        return Receta(
            RecetaID: nil,
            Nombre: self.nombreRecetaText.text,
            Descripcion: self.procedimientoText.text,
            Dificultad:  self.dificultadControl.titleForSegment(at: self.dificultadControl.selectedSegmentIndex),
            TiempoCoccion: self.tiempoCoccionText.text,
            Categoria: String(describing: Categoria.allCases[self.categoriaPicker.selectedRow(inComponent: 0)]),
            NUsuario: ""
        )
    }
    
    func crearReceta(recetaNueva: Receta){
        do{
            let peticion = try URLRequest(endpoint: puntoDeAcceso, operacion: Operacion.alta, receta: recetaNueva)
            
            URLSession.shared.dataTask(with: peticion)
            {
                (data, response, error) in
                DispatchQueue.main.async
                {
                    guard let datos =  data else { return }
                    do
                    {
                        let recetasDevueltas = try JSONDecoder().decode([Receta].self, from: datos)
                        recetas.append(recetasDevueltas.first!)
                        self.present(controlador: UIAlertController(bonbonTipo: .informativo, mensaje: "Se ha creado la receta con exito"), tipo: UIAlertController.BonbonAlertType.informativo)
                        self.reiniciarFormulario()
                    }catch _{
                        self.present(controlador: UIAlertController(bonbonTipo: .error, mensaje: "Ha ocurrido un error al intentar crear la receta"), tipo: UIAlertController.BonbonAlertType.error)
                    }
                }
            }.resume()
        }catch _{
            self.present(controlador: UIAlertController(bonbonTipo: .error, mensaje: "Ha ocurrido un error al intentar crear la receta"), tipo: UIAlertController.BonbonAlertType.error)
        }
    }
    
    func reiniciarFormulario(){
        self.nombreRecetaText.text = ""
        self.procedimientoText.text = ""
        self.dificultadControl.selectedSegmentIndex = 0
        self.tiempoCoccionText.text = ""
        self.categoriaPicker.selectRow(0, inComponent: 0, animated: true)
    }
}

