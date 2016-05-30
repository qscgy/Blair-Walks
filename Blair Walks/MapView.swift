//
//  MapView.swift
//  Blair Walks
//
//  Created by Sam Ehrenstein on 5/29/16.
//  Copyright © 2016 MBHS Smartphone Programming Club. All rights reserved.
//

import UIKit

class MapView: UIView {
    
    var start:String!
    var end:String!
    var path:[Vertex]!
    var points:[String:CGPoint]!    //every vertex, not just the ones that we're using
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //print(points)
        let startPt=points[start]
        //let endPt=points[end]
        
        let width:CGFloat=3300
        let height:CGFloat=2266
        
        //let scale=view.frame.height/route.image!.size.height
        let scale=self.frame.height/width
        print(scale)
        //let size=CGSizeApplyAffineTransform(route.image!.size, CGAffineTransformMakeScale(scale, scale))
        //let size=CGSizeMake(width*scale, height*scale)
        
        //UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        let context=UIGraphicsGetCurrentContext()
        //print(context.debugDescription)
        let xScale:CGFloat=self.bounds.width/width
        let yScale:CGFloat=self.bounds.height/height
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
        //route.image=UIGraphicsGetImageFromCurrentImageContext()
        //UIGraphicsEndImageContext()
        
        //route.contentMode = .ScaleAspectFit
    }
    

}
