//
//  PQNode.swift
//  Blair Walks
//
//  Created by Sam Ehrenstein on 9/24/15.
//  Copyright © 2015 MBHS Smartphone Programming Club. All rights reserved.
//

import Foundation
class PQNode<T>{
    var next:PQNode?
    var value:T
    var priority:Int
    init(value:T,priority:Int){
        self.value=value
        self.priority=priority
    }
    func treatAsNil()->Bool{    //idk how to make it be able to be nil
        return priority==Int.min
    }
}
/*
class PriorityQueue<T>{
    var head:PQNode<T>
    init(headVal:T,headPri:Int){
        head=PQNode<T>(value: headVal, priority: headPri)
    }
    func add(val:T,pri:Int){
        var last=head
        var atEnd:Bool=false
        //iterate until we find the right place, or hit the end
        while last.priority<pri && !atEnd{
            if let _=last.next{
                last=last.next!
            } else {
                atEnd=true
            }
        }
        if let _=last.next{
            
        } else {
            atEnd=true
        }
        if atEnd{   //last.next is nil
            last.next=PQNode<T>(value: val, priority: pri)
        } else {
            //last -> new node -> tmp
            let tmp=last.next!  //we know it's not nil
            last.next=PQNode<T>(value: val, priority: pri)
            last.next!.next=tmp
            //just realized my list was doubly linked--oops (too complicated) (I fixed it)
        }
    }
    func poll()->T{
        let tmp=head.value
        if let _=head.next{
            head=head.next!
        } else {
            head.priority=Int.min
        }
        return tmp
    }
    
    func isEmpty()->Bool{
        return head.treatAsNil()
    }
}
*/