//
//  ViewController.swift
//  Practica2
//
//  Created by Juan Carlos Díaz Torres on 24/09/2017.
//  Copyright © 2017 Juan Carlos Díaz Torres. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FuncProtocol {
    
    @IBOutlet weak var graphic1: Graphics!
    @IBOutlet weak var graphic2: Graphics!
    @IBOutlet weak var graphic3: Graphics!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Conexion entre clases
        graphic1.dataSource = self
        graphic2.dataSource = self
        graphic3.dataSource = self
        
        //Podria acceder aqui a las escalas
        graphic1.scaleX = 1.0
        graphic1.scaleY = Double(slider.value)
        graphic2.scaleX = 1.0
        graphic1.scaleY = Double(slider.value)
        graphic3.scaleX = 1.0
        graphic1.scaleY = Double(slider.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Control del slider
    
    @IBAction func sliderScale(_ sender: UISlider) {
        graphic1.scaleY = Double(slider.value)
        graphic1.setNeedsDisplay()

        graphic2.scaleY = Double(slider.value)
        graphic2.setNeedsDisplay()
        
        graphic3.scaleY = Double(slider.value)
        graphic3.setNeedsDisplay()
    }
    
    
    //Protocolo
    func startFor(_ graphic : Graphics) -> Double {
        return 0
    }
    
    func endFor(_ graphic : Graphics) -> Double {
        return 300.0
    }
    
    func nextPoint(_ graphic: Graphics, pointAt index: Double) -> FunctionPoint {
        switch graphic {
        case graphic1:
            return FunctionPoint(x: index, y: sin(index))
        case graphic2:
            return FunctionPoint(x: index, y: tan(index))
        case graphic3:
            return FunctionPoint(x: index, y: exp(-1000*index))
        default:
            return FunctionPoint(x: 0.0, y: 0.0)
        }
    }
}

