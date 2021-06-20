//
//  EditadoController.swift
//  Bonbon
//
//  Created by Angel Mendez on 13/06/21.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox

class EditadoController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var textProcedimiento: UITextField!
    @IBOutlet weak var swDificultad: UISegmentedControl!
    @IBOutlet weak var textTiempoCoccion: UITextField!
    @IBOutlet weak var pickerCategoria: UIPickerView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        tfNombre.text = recetaSeleccionada?.Nombre
        tfNombre.delegate = self
        
        textProcedimiento.text = recetaSeleccionada?.Descripcion
        textProcedimiento.delegate = self
        
        textTiempoCoccion.text = recetaSeleccionada?.TiempoCoccion
        textTiempoCoccion.delegate = self
        
        pickerCategoria.dataSource = self
        pickerCategoria.delegate = self
        
        switch (recetaSeleccionada?.Dificultad){
        case "Facil":
            swDificultad.selectedSegmentIndex = 0
        case "Medio":
            swDificultad.selectedSegmentIndex = 1
        case "Dificil":
            swDificultad.selectedSegmentIndex = 2
        default:
            break;
        }
        
        switch (recetaSeleccionada?.Categoria){
        case "desayuno":
            self.pickerCategoria.selectRow(0, inComponent: 0, animated: true)
        case "cena":
            self.pickerCategoria.selectRow(1, inComponent: 0, animated: true)
        case "almuerzo":
            self.pickerCategoria.selectRow(2, inComponent: 0, animated: true)
        case "postre":
            self.pickerCategoria.selectRow(3, inComponent: 0, animated: true)
        default:
            break;
        }
        
        self.textTiempoCoccion.addDoneButtonToKeyboard(myAction:  #selector(self.textTiempoCoccion.resignFirstResponder));
        
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
    
    
    @IBAction func guardar(_ sender: UIButton) {
        let recetaAEditar = self.traerReceta()
        
        let validador = RecetaValidator(receta: recetaAEditar);
        
        if(validador.isValid()){
            self.editarReceta(receta: recetaAEditar)
        }else{
            self.present(controlador: UIAlertController(bonbonTipo: .error, mensaje: validador.getErrors()), tipo: UIAlertController.BonbonAlertType.error)
        }
    }
    
    func traerReceta() -> Receta{
        return Receta(RecetaID: recetaSeleccionada!.RecetaID, Nombre: self.tfNombre.text, Descripcion: self.textProcedimiento.text, Dificultad: self.swDificultad.titleForSegment(at: self.swDificultad.selectedSegmentIndex), TiempoCoccion: self.textTiempoCoccion.text, Categoria: String(describing: Categoria.allCases[self.pickerCategoria.selectedRow(inComponent: 0)]), NUsuario: recetaSeleccionada?.NUsuario)
    }
    
    func actualizarRecetaSeleccionada(receta : Receta){
        recetaSeleccionada!.Categoria = receta.Categoria ;
        recetaSeleccionada!.TiempoCoccion = receta.TiempoCoccion
        recetaSeleccionada!.Descripcion = receta.Descripcion
        recetaSeleccionada!.Nombre = receta.Nombre
        recetaSeleccionada!.Dificultad = receta.Dificultad
    }
    
    
    func editarReceta(receta: Receta){
        do{
            let peticion = try  URLRequest(endpoint: puntoDeAcceso, operacion: Operacion.edicion, receta: receta)
            
            URLSession.shared.dataTask(with: peticion)
            {
                (data, response, error) in
                DispatchQueue.main.async
                {
                    self.present(controlador: UIAlertController(bonbonTipo: .informativo, mensaje: "Se ha creado editado la receta con exito"), tipo: UIAlertController.BonbonAlertType.informativo)
                    self.actualizarRecetaSeleccionada(receta: receta)
                }
            }.resume()
        }catch _{
            self.present(controlador: UIAlertController(bonbonTipo: .error, mensaje: "Ha ocurrido un error al intentar editar la receta"), tipo: UIAlertController.BonbonAlertType.error)
        }
        
    }
    
    
    
    
}
