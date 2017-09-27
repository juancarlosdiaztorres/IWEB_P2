//
//  Graphics.swift
//  Practica2
//
//  Created by Juan Carlos Díaz Torres on 24/09/2017.
//  Copyright © 2017 Juan Carlos Díaz Torres. All rights reserved.
//

import UIKit

protocol FuncProtocol {
    func startFor(_ graphic : Graphics) -> Double //Inicio
    func endFor(_ graphic : Graphics) -> Double //Final
    func nextPoint(_ graphic : Graphics, pointAt index: Double) -> FunctionPoint
}

struct FunctionPoint {
    var x : Double = 0.0
    var y : Double = 0.0
}


class Graphics: UIView {
    var dataSource : FuncProtocol!
    var scaleX = 1.0
    var scaleY = 1.0
    
    
    override func draw(_ rect: CGRect) {
        axis()
        trajectory()
    }
    
    private func axis() {
        let w = bounds.width
        let h = bounds.height
        let pathy = UIBezierPath()
        let pathx = UIBezierPath()
        
        pathy.move(to: CGPoint(x : w/2, y : 0.0))
        pathy.addLine(to: CGPoint(x : w/2, y : h))
        pathy.lineWidth = 2
        UIColor.black.setStroke()
        pathy.stroke()
        
        pathx.move(to: CGPoint(x : 0, y : h/2))
        pathx.addLine(to: CGPoint(x : w, y : h/2))
        pathx.lineWidth = 2
        UIColor.black.setStroke()
        pathx.stroke()
        
    }
    
    private func trajectory() {
        //Path vacío
        let path = UIBezierPath()
        
        //Posicionamiento
        let h = bounds.height
        let w = bounds.width
        path.move(to: CGPoint(x: w/2, y: h/2))
        
        //Variables path (0, 200 y rango)
        let P0 = dataSource.startFor(self)
        let PF = dataSource.endFor(self)

        for p in stride(from: P0, to: PF, by: 0.1) {
        
            let v = dataSource.nextPoint(self, pointAt: p)
            let x = scalingX(v.x)
            let y = scalingY(v.y)
            
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
    
    private func scalingX(_ scaleInX : Double) ->Double {
        let weight = Double(bounds.width)
        return ((weight/2) + (scaleInX*scaleX))
        
    }
    
    private func scalingY(_ scaleInY : Double) ->Double {
        let height = Double(bounds.height)
        return ((height/2) - (scaleInY*scaleY))
        
    }
    
}
