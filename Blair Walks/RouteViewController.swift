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
    var path:[Vertex]!
    var points:[String:CGPoint]!    //every vertex, not just the ones that we're using
    override func viewDidLoad() {
        super.viewDidLoad()
        
        route=UIImageView(image: UIImage(named: "FullMapRose.png"))
        scrollView=UIScrollView(frame: view.bounds)
        scrollView.contentSize=route.bounds.size
        scrollView.addSubview(route)
        view.addSubview(scrollView)
        
        //route.bounds=view.bounds
        //route.image=UIImage(named: "FullMapRose.png")
        //print(scrollView.zoomScale)
        
        //print(route.image)
        drawPath()
    }
    
    func drawPath(){
        
        //print(points)
        let startPt=points[start]
        //let endPt=points[end]
        
        let width:CGFloat=3300
        let height:CGFloat=2266
        /*
        //let scale=view.frame.height/route.image!.size.height
        let scale=view.frame.height/width
        print(scale)
        //let size=CGSizeApplyAffineTransform(route.image!.size, CGAffineTransformMakeScale(scale, scale))
        let size=CGSizeMake(width, height)
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        let context=UIGraphicsGetCurrentContext()
        //print(context.debugDescription)
        let xScale:CGFloat=1
        let yScale:CGFloat=1
        //route.image!.drawInRect(CGRect(origin: CGPointZero, size: size))
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
        
        //route.contentMode = .ScaleAspectFit
        */
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
        for v:Vertex in path!{
            if v.name != start!{
                CGContextAddLineToPoint(context, points[v.name]!.x, (height-points[v.name]!.y))
            }
        }
        
        //CGContextAddLineToPoint(context, 0, 0)
        
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
