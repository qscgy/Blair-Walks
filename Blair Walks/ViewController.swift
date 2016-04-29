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
    @IBOutlet var routeOutput: UITextView!
    var pathStr:String!
    var pathfinder:PathfinderModel!
    var path:[Vertex: Vertex]=[Vertex(name: ""): Vertex(name: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pathfinder=PathfinderModel(file: "JUNCTIONS_TEST",coords: "PIXEL_COORDS")
        routeOutput.text=""
        startInput.delegate=self
        endInput.delegate=self
        
        //pathfinder.findShortestPath("A", end: "E")
        //print("Done")
    }

    @IBAction func findPath(sender: AnyObject) {
        let start=startInput.text!
        let end=endInput.text!
        pathStr=pathfinder.findShortestPath(start, end: end)
        routeOutput.text=pathStr
        //print("done")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func viewTapped(sender: AnyObject) {
        if startInput.isFirstResponder(){
            startInput.resignFirstResponder()
        } else if endInput.isFirstResponder(){
            endInput.resignFirstResponder()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="showMap"){
            let vc=segue.destinationViewController as! RouteViewController
            vc.pathStr=pathStr
            vc.start=startInput!.text!
            vc.end=endInput.text!
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //print("resigning")
        return true
    }
}

