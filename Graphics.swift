//
//  Graphics.swift
//  Practica2
//
//  Created by Juan Carlos Díaz Torres on 24/09/2017.
//  Copyright © 2017 Juan Carlos Díaz Torres. All rights reserved.
//

import UIKit

protocol FuncProtocol {
    func start() -> Double //Inicio
    func end() -> Double //Final
    func pointAt(index: Double) -> FunctionPoint
}

struct FunctionPoint {
    var x : Double = 0.0
    var y : Double = 0.0
}


class Graphics: UIView {
    
    //Objeto para start y end. Comunico Graphics con ViewController
    var dataSource : FuncProtocol!
    
    override func draw(_ rect: CGRect) {
        
        //Path vacío
        let path = UIBezierPath()
        
        //Posicionamiento NPI de como colocarlos
        let h = bounds.height
        let w = bounds.width
        
        //Variables path (0, 200 y rango)
        let P0 = dataSource.start()
        let PF = dataSource.end()
        let deltaP = (PF - P0) / 100
        
        //Continuo el path
        path.move(to: CGPoint(x: 0.0, y: 0.0))

        for p in stride(from: P0, to: PF, by: deltaP) {
        
            let v = dataSource.pointAt(index: p)
            let x = v.x
            let y = v.y
            
            let punto = CGPoint(x: x, y: y)
            
            //Actualizo el dibujo
            path.addLine(to: punto)
        
    }
        //Trazo
        path.lineWidth = 1.5
        UIColor.red.setStroke()
        
        //pinta
        path.stroke()

}
}
