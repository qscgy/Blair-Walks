//
//  PathfinderModel.swift
//  Blair Walks
//



//  Created by Sam Ehrenstein on 9/24/15.
//  Copyright © 2015 MBHS Smartphone Programming Club. All rights reserved.
//

import Foundation
import UIKit

class PathfinderModel{
    var map:Graph
    init(edges:[Edge]){
        map=Graph(edges: edges)
    }
    func findShortestPath(start:String,end:String,output:UITextView!){
        map.findShortestPath(start,end: end,output:output)
    }
}

class Edge{
    var v1:String
    var v2:String
    var dist:Int
    init(v1:String,v2:String,dist:Int){
        self.v1=v1
        self.v2=v2
        self.dist=dist
    }
}

class Vertex:Hashable,Comparable{
    var name:String
    var dist=Int.max
    var neighbors=[Vertex: Int]()
    init(name:String){
        self.name=name
    }
    var hashValue:Int{
        get{
            return name.hashValue
        }
    }
}

class Graph{
    var graph:[String: Vertex]  //maps names to vertices
    init(edges:[Edge]){
        graph=[String: Vertex]()
        
        //get all vertices in graph
        for e:Edge in edges{
            if let _=graph[e.v1]{
                
            } else {
                graph[e.v1]=Vertex(name: e.v1)
            }
            if let _=graph[e.v2]{
            } else {
                graph[e.v2]=Vertex(name: e.v2)
            }
        }
        
        //set neighbors of each vertex to the vertex on the other end of the edge
        for e:Edge in edges{
            graph[e.v1]!.neighbors[graph[e.v2]!]=e.dist
            graph[e.v2]!.neighbors[graph[e.v1]!]=e.dist
        }
    }
    
    //find shortest path with Dijkstra's algorithm
    func findShortestPath(start:String,end:String,output:UITextView!)->[Vertex: Vertex]{
        let source=graph[start]
        var cameFrom=[Vertex: Vertex]()
        //var costTo=[Vertex: Int]()
        cameFrom[source!]=source!
        let frontier=OtherPriorityQueue<Vertex>()
        frontier.push(0, item: source!)
        source!.dist=0
        
        var current:Vertex=source!
        while !frontier.isEmpty(){
            current=frontier.pop().1
            //print("Main loop:"+current.name)
            //print(end)
            if(current.name==end){
                break
            }
            var neighbors=current.neighbors
            
            //search a
            for v:Vertex in neighbors.keys{
                let dist=current.dist+neighbors[v]!  //distance to current + distance from current to neighbor=total dist to neighbor
                if let _=cameFrom[v]{   //v has already been found
                    //I don't know how to search a dictionary
                    if v.dist>dist{  //better path
                        v.dist=dist
                        cameFrom[v]=current
                        frontier.push(dist, item: v)
                    }
                } else {
                    v.dist=dist
                    cameFrom[v]=current
                    frontier.push(dist, item: v)
                }
            }
        }
        printPath(cameFrom,end: graph[end]!,output: output)
        return cameFrom
    }
}

func printPath(cameFrom:[Vertex: Vertex],end:Vertex,output:UITextView!){
    var current=end
    var keepGoing=true
    /*
    print("\n")
    for v:Vertex in cameFrom.keys{
        print("\(v.name) \(cameFrom[v]!.name)")
    }
    print("\n")
    */
    var path=""
    while keepGoing{
        path+=current.name+"\n"
        if let tmp=cameFrom[current]{
            if(current != tmp){ //source came from itself, and we don't want an infinite loop
                current=tmp
            } else {
                keepGoing=false //stop if we hit the source, since it is the only vertex that can come from itself
            }
        } else {    //stop if current didn't come from anything (shouldn't have to ever run)
            keepGoing=false
        }
    }
    output.text=path
}

func drawLine(from:CGPoint,to:CGPoint){
    
}

func initEdgesFromFile(file:String)->[Edge]{
    
}

//protocol-required operators for Vertex
func ==(left: Vertex, right: Vertex) -> Bool {
    return left.hashValue == right.hashValue
}

func <(l:Vertex,r:Vertex)->Bool{
    return l.dist<r.dist
}
















