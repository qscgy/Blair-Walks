//
//  RouteViewController.swift
//  Blair Walks
//
//  Created by Sam Ehrenstein on 10/17/15.
//  Copyright © 2015 MBHS Smartphone Programming Club. All rights reserved.
//

import UIKit

class RouteViewController: UIViewController {
    @IBOutlet var route: UIImageView!
    var coords=[String:CGPoint]()
    var pathStr:String=""
    override func viewDidLoad() {
        super.viewDidLoad()
        //set route to fill screen
        let screenSize:CGRect=self.view.frame
        route.frame=screenSize
    }
    
    func getCoordsFromFile(file:String){
        let path=NSBundle.mainBundle().pathForResource(file, ofType: "csv")
        let fileStr:String
        
        //set fileStr to be the contents of file
        do{
            try fileStr=String(contentsOfFile: path!)
        }
        catch _{
            fileStr=""
        }
        let contentsArray=fileStr.componentsSeparatedByString("\n") //split line by line
        
        //create an edge from each line
        for str:String in contentsArray{
            //print(str)
            let data=str.componentsSeparatedByString(",")
            //print(edgeData)
            coords[data[0]]=CGPoint(x: Double(data[1])!, y: Double(data[2])!)
        }

    }
}
