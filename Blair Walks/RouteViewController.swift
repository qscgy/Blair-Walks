//
//  RouteViewController.swift
//  Blair Walks
//
//  Created by Sam Ehrenstein on 10/17/15.
//  Copyright © 2015 MBHS Smartphone Programming Club. All rights reserved.
//

import UIKit

class RouteViewController: UIViewController,UIScrollViewDelegate {
    var route: UIImageView!
    var scrollView: UIScrollView!
    var start:String!
    var end:String!
    var path:[String:[Vertex]]!
    var points:[String:CGPoint]!    //every vertex, not just the ones that we're using
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        route=UIImageView(image: UIImage(named: "FullMapRose.png"))
        scrollView=UIScrollView(frame: view.bounds)
        scrollView.contentSize=route.bounds.size
        scrollView.minimumZoomScale=0.1
        scrollView.delegate=self
        scrollView.addSubview(route)
        view.addSubview(scrollView)
        //scrollView.zoomScale=0.3
        
        //route.bounds=view.bounds
        //route.image=UIImage(named: "FullMapRose.png")
        //print(scrollView.zoomScale)
        
        //print(route.image)
        drawPath()
        scrollView.zoomScale=0.3
    }
    
    /*
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        route.frame=CGRect(origin: CGPointZero, size: size)
        scrollView.frame=route.frame
        scrollView.contentSize=route.frame.size
        drawPath()
    }
    */
    
    
    func drawPath(){
        let startPt=points[start]
        let width:CGFloat=route.frame.width
        let height:CGFloat=route.frame.height
        let scale=view.bounds.height/route.image!.size.height
        print(scale)
        //let size=CGSizeApplyAffineTransform(route.image!.size, CGAffineTransformMakeScale(scale, scale))
        let size=CGSizeMake(width, height)
        print(size.width)
        print(size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        route.image!.drawInRect(CGRect(origin: CGPointZero, size: size))
        CGContextMoveToPoint(context, startPt!.x, (height-startPt!.y))
        for v:Vertex in path["floor1"]!{
            if v.name != start!{
                CGContextAddLineToPoint(context, points[v.name]!.x, (height-points[v.name]!.y))
            }
        }
        
        //CGContextAddLineToPoint(context, 0, 0)
        
        CGContextSetLineCap(context, .Round)
        CGContextSetLineWidth(context, 15)
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        CGContextStrokePath(context)
        
        route.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        //print(scrollView.zoomScale)
        return self.route
    }
}
