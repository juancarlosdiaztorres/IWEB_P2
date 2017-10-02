//
//  ViewController.swift
//  Practica2
//
//  Created by Juan Carlos Díaz Torres on 24/09/2017.
//  Copyright © 2017 Juan Carlos Díaz Torres. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FuncProtocol {
   
    //Objetos de los modelos
    let trajectoryModel = TrajectoryModel()
    let tankModel = TankModel()
    
    @IBOutlet weak var outSpeedTimeFuncView: Graphics!
    @IBOutlet weak var outSpeedHeightFuncView: Graphics!
    @IBOutlet weak var waterHeightTimeFuncView: Graphics!
    @IBOutlet weak var trajectoryTimeFuncView: Graphics!
    @IBOutlet weak var timeSlider: UISlider!
    
    @IBOutlet weak var vtLabel: UILabel!
    @IBOutlet weak var timeValue: UILabel!
    @IBOutlet weak var htLabel: UILabel!
    
    var trajectoryTime : Double = 0.0 {
        didSet{
            outSpeedTimeFuncView.setNeedsDisplay()
            outSpeedHeightFuncView.setNeedsDisplay()
            waterHeightTimeFuncView.setNeedsDisplay()
            trajectoryTimeFuncView.setNeedsDisplay()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Conexion entre clases
        outSpeedTimeFuncView.dataSource = self
        outSpeedHeightFuncView.dataSource = self
        waterHeightTimeFuncView.dataSource = self
        trajectoryTimeFuncView.dataSource = self
        
        //Escalado y etiquetado
        outSpeedTimeFuncView.scaleX = 20
        outSpeedTimeFuncView.scaleY = 20
        outSpeedTimeFuncView.textX = "Time"
        outSpeedTimeFuncView.textY = "Out Speed"
        
        outSpeedHeightFuncView.scaleX = 100
        outSpeedHeightFuncView.scaleY = 100
        outSpeedHeightFuncView.textX = "Height"
        outSpeedHeightFuncView.textY = "Out Speed"
        
        waterHeightTimeFuncView.scaleX = 0.2
        waterHeightTimeFuncView.scaleY = 0.2
        waterHeightTimeFuncView.textX = "Height"
        waterHeightTimeFuncView.textY = "Level of Water"
        
        trajectoryTimeFuncView.scaleX = 25
        trajectoryTimeFuncView.scaleY = 25
        trajectoryTimeFuncView.textX = "Time"
        trajectoryTimeFuncView.textY = "Trajectory"
        
        //Colocación tiesto y regadera
        trajectoryModel.originPos = (0, 2)
        trajectoryModel.targetPos = (2, 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Cada vez que muevo el slider, debo captar su valor y cambiarlo para que la trayectoria funcione
    @IBAction func updateTime(_ sender: UISlider) {
        trajectoryTime = Double(sender.value)
        let time = (trajectoryTime*1000).rounded()/1000
        timeValue.text = "t = " + String(time)
    }
    
    
    //Protocolo
    func startFor(_ graphic: Graphics) -> Double {
        return 0.0
    }
    
    func endFor(_ graphic: Graphics) -> Double {
        switch graphic {
        case outSpeedTimeFuncView:
            return tankModel.timeToEmpty
        case outSpeedHeightFuncView:
            return tankModel.initialWaterHeight
        case waterHeightTimeFuncView:
            return tankModel.timeToEmpty
        case trajectoryTimeFuncView:
            let h = tankModel.waterHeightAt(time: trajectoryTime)
            let v = tankModel.waterOutputSpeed(waterHeight: h)
            trajectoryModel.speed = v
            return trajectoryModel.timeToTarget()
        default:
            return 0.0
        }
    }
    
    func nextPoint(_ graphic: Graphics, pointAt index: Double) -> FunctionPoint {
        switch graphic {
        case outSpeedTimeFuncView:
            let time = index
            let h = tankModel.waterHeightAt(time: time)
            let v = tankModel.waterOutputSpeed(waterHeight: h)
            return FunctionPoint(x: time, y : v)
        case outSpeedHeightFuncView:
            let h = index
            let v = tankModel.waterOutputSpeed(waterHeight: h)
            return FunctionPoint(x: h, y: v)
        case waterHeightTimeFuncView:
            let time = index
            let h = tankModel.waterHeightAt(time: time)
            return FunctionPoint(x: time, y: h)
        case trajectoryTimeFuncView:
            let time = index
            let h = tankModel.waterHeightAt(time: time)
            let v = tankModel.waterOutputSpeed(waterHeight: h)
            trajectoryModel.speed = v
            let pos = trajectoryModel.positionAt(time: time)
            return FunctionPoint(x: pos.x, y :pos.y)
        default:
            return FunctionPoint( x: 0.0, y: 0.0)
        }
    }
    
    func pointOfInterest(_ graphic: Graphics) -> [FunctionPoint] {
        switch graphic{
        case outSpeedTimeFuncView:
            let time = trajectoryTime
            let h = tankModel.waterHeightAt(time: time)
            let v = tankModel.waterOutputSpeed(waterHeight: h)
            vtLabel.text = String(round(v)) + " m/seg"
            return [FunctionPoint(x:time, y:v)]
        case outSpeedHeightFuncView:
            let h = trajectoryTime
            let v = tankModel.waterOutputSpeed(waterHeight: h)
            return [FunctionPoint(x: h, y:v)]
        case waterHeightTimeFuncView:
            let time = trajectoryTime
            let h = tankModel.waterHeightAt(time: time)
            htLabel.text = String(round(h)) + " m"
            return [FunctionPoint(x:time, y:h)]
        case trajectoryTimeFuncView:
            return [FunctionPoint(x: trajectoryModel.originPos.x, y: trajectoryModel.originPos.y ), FunctionPoint(x:trajectoryModel.timeToTarget(), y: 0)]
        default:
            return [FunctionPoint(x:0, y:0)]
        }
    }
}
