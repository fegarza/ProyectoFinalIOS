//
//  ListadoController.swift
//  Bonbon
//
//  Created by Felipe Garza on 13/06/21.
//

import Foundation

import UIKit

class ListadoController: UITableViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        self.traerDatos()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.5
        
        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPress(longPressGesture: UILongPressGestureRecognizer) {
        let p = longPressGesture.location(in: self.tableView)
        
        let indexPath = self.tableView.indexPathForRow(at: p)
        
        if longPressGesture.state == UIGestureRecognizer.State.began {
            self.present(controlador: UIAlertController(bonbonTipo: .confirmar, mensaje: "Esta seguro que desea eliminar la receta?",  handler: {
                (alert: UIAlertAction) in
                self.eliminarReceta( indexPath: indexPath!)
            } ), tipo: UIAlertController.BonbonAlertType.confirmar)
        }
    }
    
    func eliminarReceta(  indexPath: IndexPath){
        do{
            let peticion = try  URLRequest(endpoint: puntoDeAcceso, operacion: Operacion.baja, receta: recetas[indexPath.row])
            
            URLSession.shared.dataTask(with: peticion)
            {
                (data, response, error) in
                DispatchQueue.main.async
                {
                    recetas.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
                
            }.resume()
        }catch let error{
            print(error)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        traerDatos()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recetas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        cell.textLabel?.text = recetas[indexPath.row].Nombre
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recetaSeleccionada = recetas[indexPath.row]
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let editadoViewController = storyBoard.instantiateViewController(withIdentifier: "editarView") as! EditadoController
        self.navigationController?.pushViewController(editadoViewController, animated: true)
        //self.present(editadoViewController, animated: true, completion: nil)
    }
    
    
    func traerDatos(){
        do{
            
            let peticion = try URLRequest(endpoint: puntoDeAcceso, operacion: Operacion.consulta, receta: nil)
            
            URLSession.shared.dataTask(with: peticion)
            {
                (data, response, error) in
                DispatchQueue.main.async
                {
                    guard let datos =  data else { return }
                    do
                    {
                        recetas = try JSONDecoder().decode([Receta].self, from: datos)
                    }catch let jsonError{
                        print(jsonError)
                    }
                    self.tableView.reloadData();
                }
                
            }.resume()
            
        }catch{
            
        }
    }
    
    
    
}

