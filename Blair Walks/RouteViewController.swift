//
//  RouteViewController.swift
//  Blair Walks
//
//  Created by Sam Ehrenstein on 10/17/15.
//  Copyright © 2015 MBHS Smartphone Programming Club. All rights reserved.
//

import UIKit

class RouteViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet var route: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    var start:String!
    var end:String!
    var path:[Vertex]!
    var points:[String:CGPoint]!    //every vertex, not just the ones that we're using
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLayoutSubviews()
        //set route to fill screen
        let screenSize:CGRect=self.view.frame
        route.frame=screenSize
        route.image=UIImage(named: "FullMapRose.png")
        
        scrollView.minimumZoomScale=1.0
        scrollView.maximumZoomScale=4.0
        scrollView.delegate=self
        
        //print(scrollView.zoomScale)
        
        //print(route.image)
        drawPath()
    }
    
    func drawPath(){
        //print(points)
        let startPt=points[start]
        //let endPt=points[end]
        UIGraphicsBeginImageContext(route.frame.size)
        let context=UIGraphicsGetCurrentContext()
        let xScale=view.bounds.width/10.0
        let yScale=view.bounds.height/10.0
        route.image?.drawInRect(CGRect(x: 0, y: 0, width: route.frame.width, height: route.frame.height))
        //route.image?.drawAtPoint(CGPoint(x: 0, y: 0))
        
        CGContextMoveToPoint(context, startPt!.x*xScale, (10-startPt!.y)*yScale)
        for v:Vertex in path!{
            if v.name != start!{
                CGContextAddLineToPoint(context, points[v.name]!.x*xScale, (10-points[v.name]!.y)*yScale)
            }
        }
        
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, 2.0)
        CGContextStrokePath(context)
        route.image=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        route.contentMode = .ScaleAspectFit
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        //print(scrollView.zoomScale)
        return self.route
    }
}
