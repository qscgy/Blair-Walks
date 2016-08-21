//
//  RouteViewController.swift
//  Blair Walks
//
//  Created by Sam Ehrenstein on 10/17/15.
//  Copyright © 2015 MBHS Smartphone Programming Club. All rights reserved.
//
//  Note: 1 px = 2.912 in
//  Also, all of the stairs are 60 ft, give or take a few feet

import UIKit

class RouteViewController: UIViewController,UIScrollViewDelegate {
    var route: UIImageView!
    var scrollView: UIScrollView!
    var start:String!
    var end:String!
    var path:[String:[Vertex]]!     //holds each floor's portion of the path
    var points:[String:CGPoint]!    //every vertex, not just the ones that we're using
    var floor="floor1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if floor=="floor1" {
            route=UIImageView(image: UIImage(named: "FullMapRose.png"))
        } else if floor=="floor2" {
            route=UIImageView(image: UIImage(named: "FullMapRose2.png"))
        } else {
            route=UIImageView(image: UIImage(named: "FullMapRose3.png"))
        }
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
        print("hi")
        if let pathFloor=path[floor]{
        if pathFloor.count>0{
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
        
        //draw all of the points on the floor for this VC
        //print(pathFloor.first?.name)
        CGContextMoveToPoint(context, points[(pathFloor.first?.name)!]!.x, (height-points[(pathFloor.first?.name)!]!.y))
        for v:Vertex in path[floor]!{
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
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        //print(scrollView.zoomScale)
        return self.route
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="toF2"){
            let vc=segue.destinationViewController as! RouteViewController
            vc.path=path
            vc.start=start
            vc.end=end
            vc.points=points
            if(floor=="floor1"){
                vc.floor="floor2"
            } else {
                vc.floor="floor3"
            }
        }
    }

}
