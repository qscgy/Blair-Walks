//
//  ViewController.swift
//  Blair Walks
//
//  Created by Sam Ehrenstein on 9/24/15.
//  Copyright © 2015 MBHS Smartphone Programming Club. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,SelectPointsViewControllerDelegate {
    
    @IBOutlet var startInput: UITextField!
    @IBOutlet var endInput: UITextField!
    @IBOutlet var routeOutput: UITextView!
    var pathStr:String!
    var path:[String:[Vertex]]!
    var pathfinder:PathfinderModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pathfinder=PathfinderModel(file: "JUNCTIONS_TEST",coords: "floor1_coords")
        routeOutput.text=""
        startInput.delegate=self
        endInput.delegate=self
    }

    @IBAction func findPath(sender: AnyObject) {
        let start=startInput.text!
        let end=endInput.text!
        path=pathfinder.findShortestPath(start, end: end)
        pathStr=pathToString(path)
        routeOutput.text=pathStr
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
            vc.path=path!  //pass path as string
            vc.start=startInput!.text!
            vc.end=endInput.text!
            vc.points=convertCoords(pathfinder.coords)     //pass coordinate tuples as CGPoints from model to avoid having to parse the files again
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //print("resigning")
        return true
    }
    
    func selctionDidEnd(p1: CGPoint, p2: CGPoint) {
        print("back")
        startInput.text=pathfinder.closestPoint(p1)
        endInput.text=pathfinder.closestPoint(p2)
    }
    
    //converts a dictionary mapping strings to tuples representing points to one mapping those strings to equivalent CGPoints
    func convertCoords(coords:[String:(Int,Int)])->[String:CGPoint]{
        var points:[String:CGPoint] = [String:CGPoint]()
        for point in coords{
            points[point.0]=CGPoint(x: point.1.0, y: point.1.1)  //new point with x and y coordinates
        }
        return points
    }
    
    func convertPath(path:String)->[String]{
        return path.componentsSeparatedByString("\n")
    }

}

