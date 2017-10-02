//
//  TrajectoryModel.swift
//  Practica2
//
//  Created by Juan Carlos Díaz Torres on 30/09/2017.
//  Copyright © 2017 Juan Carlos Díaz Torres. All rights reserved.
//

import Foundation

//Modelo de datos para representar una tray parabolica que pasa por dos ptos dados
//Vlanzamiento es conocida, pero el angulo inicial no lo es.
//Pero hay que calcula el angulo inicial para que pase por los dos puntos dados.

class TrajectoryModel {
    
    //Posicion origen del disparo.
    var originPos = (x: 0.0, y: 0.0){
        didSet {
            update()
        }
    }
    
    //Posicion del destino del disparo
    var targetPos = (x: 0.0, y: 0.0) {
        didSet {
            update()
        }
    }
    
    //Velocidad inicial
    var speed: Double = 0.0 {
        didSet {
            update()
        }
    }
    
    //Angulo disparo inicial
    private var angle: Double = 0.0
    
    //Vinicial horizontal
    private var speedX = 0.0
    
    //Velocidad inicial en vertical
    private var speedY = 0.0
    
    //Actualiza los datos de la trayectoria si cambia la posicion del origen, la destino o la Vinicial
    private func update() {
        let g = Constants.g
        let xf = targetPos.x - originPos.x
        let yf = targetPos.y - originPos.y
    
        angle = atan((pow(speed,2) + sqrt(pow(speed,4) - g*g*xf*xf - 2*g*yf*pow(speed, 2))) / (g*xf))
    
        if !angle.isNormal {
            speedX = 0
            speedY = 0
        }else{
            speedX = speed * cos(angle)
            speedY = speed * sin(angle)
        }
    }
    
    //Tiempo que tarda origen-destino
    func timeToTarget() -> Double {
        let t = (targetPos.x - originPos.x) / speedX
        return t.isNormal ? t : 0
    }
    
    //Posicion en un momento dado
    func positionAt(time: Double) -> (x: Double, y: Double) {
        let x = originPos.x + speedX * time
        let y = originPos.y + speedY * time - 0.5 * Constants.g * time * time
        return (x,y)
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

