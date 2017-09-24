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
    

    func start() -> Double {
        return 0.0
    }
    
    func end() -> Double {
        return 200.0
    }
    
    func pointAt(index: Double) -> FunctionPoint {
        return FunctionPoint(x: index, y: 150*cos(index))
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Conexion entre clases
        graphic1.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

