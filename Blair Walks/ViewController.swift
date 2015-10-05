//
//  ViewController.swift
//  Blair Walks
//
//  Created by Sam Ehrenstein on 9/24/15.
//  Copyright © 2015 MBHS Smartphone Programming Club. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var startInput: UITextField!
    @IBOutlet var endInput: UITextField!
    var pathfinder:PathfinderModel=PathfinderModel(edges: [Edge(v1: "A", v2: "B", dist: 1)])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pathfinder=PathfinderModel(edges: [Edge(v1: "A", v2: "B", dist: 1),Edge(v1: "B", v2: "C", dist: 3),
            Edge(v1: "A", v2: "C", dist: 3),Edge(v1: "C", v2: "D", dist: 2),Edge(v1: "B", v2: "E", dist: 2),
            Edge(v1: "C", v2: "E", dist: 2),Edge(v1: "D", v2: "E", dist: 3),Edge(v1: "A", v2: "D", dist: 3)])
        
        startInput.delegate=self
        endInput.delegate=self
        
        pathfinder.findShortestPath("A", end: "E")
        //print("Done")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //print("resigning")
        return true
    }


}

