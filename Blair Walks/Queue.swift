//
//  Queue.swift
//  Blair Walks
//
//  Created by Sam Ehrenstein on 4/29/16.
//  Copyright © 2016 MBHS Smartphone Programming Club. All rights reserved.
//

import Foundation

class Queue<Element>{
    var queue=[Element]()
    func enqueue(item:Element){
        queue.append(item)
    }
    func dequeue()->Element{
        return queue.first!
    }
}