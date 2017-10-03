//
//  Graphics.swift
//  Practica2
//
//  Created by Juan Carlos Díaz Torres on 24/09/2017.
//  Copyright © 2017 Juan Carlos Díaz Torres. All rights reserved.
//

import UIKit

protocol FuncProtocol: class {
    func startFor(_ graphic : Graphics) -> Double //Inicio
    func endFor(_ graphic : Graphics) -> Double //Final
    func nextPoint(_ graphic : Graphics, pointAt index: Double) -> FunctionPoint
    func pointOfInterest(_ graphic: Graphics) -> [FunctionPoint]
}

struct FunctionPoint {
    var x : Double = 0.0
    var y : Double = 0.0
}


@IBDesignable
class Graphics: UIView {
    
    @IBInspectable
    var lineWidth : Double = 2.0
    
    @IBInspectable
    var functionColor : UIColor = UIColor.red
    
    @IBInspectable
    var textX : String = "x"
    
    @IBInspectable
    var textY : String = "y"
    
    @IBInspectable
    var scaleX : Double = 1.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var scaleY : Double = 1.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var resolution : Double = 50 {
        didSet{
            setNeedsDisplay()
        }
    }
    
#if TARGET_INTERFACE_BUILDER
    var dataSource : FuncProtocol!
#else
    weak var dataSource: FuncProtocol!
#endif
    
    /// DataSource falso para que lo use el Interface Builder en tiempo de desarrollo.
    override func prepareForInterfaceBuilder() {
        
        class FakeDataSource :FuncProtocol{
            
            func startFor(_ graphic: Graphics) -> Double  {
                print("Entra en start de FakeDatasSource")
                return 0.0}
            
            func endFor(_ graphic: Graphics) -> Double {return 200.0}
            
            func nextPoint(_ graphic: Graphics, pointAt index: Double) -> FunctionPoint {
                return FunctionPoint(x: index , y: index.truncatingRemainder(dividingBy: 25))
            }
            func pointOfInterest(_ graphic: Graphics) -> [FunctionPoint]{
                return []
            }
        }
        
        dataSource = FakeDataSource()
    }
    
    override func draw(_ rect: CGRect) {
        axis()
        trajectory()
        drawPOI()
    }
    
    private func axis() {
        print("Pintando axis")
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
        print("pinta trayectoria")
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
    
    private func drawPOI() {
        let poi = dataSource.pointOfInterest(self)
        
        for p in poi {
            let x = scalingX(p.x)
            let y = scalingY(p.y)
            let path = UIBezierPath(ovalIn: CGRect(x: x-4, y: y-4, width: 8, height: 8))
            
            UIColor.blue.set()
            path.stroke()
            path.fill()
        }
    }
}
