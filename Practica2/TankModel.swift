//
//  TankModel.swift
//  Practica2
//
//  Created by Juan Carlos Díaz Torres on 30/09/2017.
//  Copyright © 2017 Juan Carlos Díaz Torres. All rights reserved.
//

import Foundation

class TankModel {
    
    //Constantes del tanque
    let radiousTank = 0.3
    let radiousPipe = 0.0025
    let initialWaterHeight = 0.5
    let timeToEmpty: Double
    
    //Constantes para facilitar cálculos
    private let areaTank: Double
    private let areaPipe: Double
    private let at2ap2m1: Double
    private let ap2at2m1: Double
    
   
    
    init(){
        //areaTank = Double.pi * pow(radiousTank, 2)
        //areaPipe = Double.pi * pow(radiousPipe, 2)
        areaTank = Double.pi*radiousTank
        areaPipe = Double.pi*radiousPipe
        at2ap2m1 = pow(areaTank/areaPipe, 2)-1
        ap2at2m1 = pow(areaPipe/areaTank, 2)-1
        timeToEmpty = sqrt(2 * initialWaterHeight * at2ap2m1 / Constants.g)
    }
        
        //Vout(h)
        func waterOutputSpeed(waterHeight h: Double) -> Double {
            //let v = sqrt((2*Constants.g*h)/ap2at2m1)
            let v = sqrt(-2*Constants.g*h/ap2at2m1)
            return max(0.0,v)
        }
        
        //Vbajada(h) en deposito
        func waterHeightSpeed(waterHeight h: Double) -> Double {
            //let v = sqrt((2*Constants.g*h)/at2ap2m1)
            let v = sqrt(2*Constants.g*h/at2ap2m1)
            return max(v,0.0)
        }
        
        //Altura de agua del depósito en función del tiempo
        func waterHeightAt(time t: Double) -> Double {
            if t > timeToEmpty {
                return 0
            }
            
            let c0 = initialWaterHeight
            let c1 = -sqrt(2 * Constants.g * initialWaterHeight / at2ap2m1)
            
            if c1.isNaN {
                return 0
            }
            
            let c2 = Constants.g * 0.5 / at2ap2m1
            return c0 + c1*t + c2 * t * t
        }
}







