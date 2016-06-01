//
//  SelectPointsViewController.swift
//  Blair Walks
//
//  Created by Sam Ehrenstein on 5/30/16.
//  Copyright © 2016 MBHS Smartphone Programming Club. All rights reserved.
//

import UIKit

protocol SelectPointsViewControllerDelegate{
    func selctionDidEnd(p1:CGPoint,p2:CGPoint,height:Int)
    func mapButtonWasTapped(p1:CGPoint,p2:CGPoint,height:Int)
}

class SelectPointsViewController: UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate {

    var map: UIImageView!
    var scrollView: UIScrollView!
    var start:CGPoint=CGPoint()
    var end:CGPoint=CGPoint()
    var startLastChanged=false   //start was the last point to be modified; if true, end will be changed on double tap
    var delegate:SelectPointsViewControllerDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map=UIImageView(image: UIImage(named: "FullMapRose.png"))
        scrollView=UIScrollView(frame: view.bounds)
        scrollView.contentSize=map.bounds.size
        scrollView.minimumZoomScale=0.1
        scrollView.delegate=self
        scrollView.addSubview(map)
        scrollView.userInteractionEnabled=true
        view.addSubview(scrollView)
        scrollView.zoomScale=0.3
        
        let tap=UITapGestureRecognizer(target: self, action: Selector("doubleTapped:"))
        tap.delegate=self
        tap.numberOfTapsRequired=2
        map.userInteractionEnabled=true
        map.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doubleTapped(recognizer:UITapGestureRecognizer){
        let touchLocation=recognizer.locationInView(map)
        let zoom=scrollView.zoomScale
        print(touchLocation)
        if(startLastChanged){
            end=touchLocation
        } else {
            start=touchLocation
        }
        startLastChanged = !startLastChanged
        
        scrollView.zoomScale=1.0
        map.image=UIImage(named: "FullMapRose")
        let width:CGFloat=map.frame.width
        let height:CGFloat=map.frame.height
        let size=CGSizeMake(width, height)
        //print(size.width)
        //print(size.height)
        
        //draws a dot at start and end
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        map.image!.drawInRect(CGRect(origin: CGPointZero, size: size))
        CGContextMoveToPoint(context, start.x, (start.y))
        CGContextAddLineToPoint(context, start.x, (start.y))
        CGContextMoveToPoint(context, end.x, (end.y))
        CGContextAddLineToPoint(context, end.x, (end.y))
        CGContextSetLineCap(context, .Round)
        CGContextSetLineWidth(context, 30)
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextStrokePath(context)
        
        map.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        scrollView.zoomScale=zoom
    }
    
    override func viewWillDisappear(animated: Bool) {
        delegate.selctionDidEnd(start, p2: end,height: Int(map.bounds.height))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        //print(scrollView.zoomScale)
        return self.map
    }

}

struct Endpoint {
    var x:CGFloat
    var y:CGFloat
    var visible=true
    
    init(x:CGFloat,y:CGFloat){
        self.x=x
        self.y=y
    }
    
}







