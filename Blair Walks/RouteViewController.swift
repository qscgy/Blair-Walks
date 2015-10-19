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
    var path:[Vertex: Vertex]=[Vertex(name: ""): Vertex(name: "")]
    override func viewDidLoad() {
        super.viewDidLoad()
        //set route to fill screen
        let screenSize:CGRect=self.view.frame
        route.frame=screenSize
    }
}
