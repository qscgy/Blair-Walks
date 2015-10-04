//
//  PathfinderModel.swift
//  Blair Walks
//



//  Created by Sam Ehrenstein on 9/24/15.
//  Copyright © 2015 MBHS Smartphone Programming Club. All rights reserved.
//

import Foundation

class PathfinderModel{
    
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
    var previous:Vertex?
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
                graph[e.v1]=Vertex(name: e.v1)
            }
            if let _=graph[e.v2]{
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
    func findShortestPath(start:String,end:String){
        var source=Vertex(name: start)
        var cameFrom=[Vertex: Vertex]()
        //var costTo=[Vertex: Int]()
        var frontier=PriorityQueue<Vertex>(headVal: source, headPri: 0)
        source.dist=0
        
        var current:Vertex
        while !frontier.isEmpty(){
            current=frontier.poll()
            if(current.name==end){
                break
            }
            var neighbors=current.neighbors
            
            //search a
            for v:Vertex in neighbors.keys{
                let dist=current.dist+neighbors[v]!  //distance to current + distance from current to neighbor=total dist to neighbor
                if let _=cameFrom[v]{
                    //I don't know how to search a dictionary
                    if v.dist<dist{  //better path
                        v.dist=dist
                        cameFrom[v]=current
                        frontier.add(v, pri: dist)
                    }
                } else {
                    v.dist=dist
                    cameFrom[v]=current
                    frontier.add(v, pri: dist)
                }
            }
        }
    }
}

//protocol-required operators for Vertex
func ==(left: Vertex, right: Vertex) -> Bool {
    return left.hashValue == right.hashValue
}

func printPath(cameFrom:[Vertex: Vertex],end:Vertex){
    
}

func <(l:Vertex,r:Vertex)->Bool{
    return l.dist<r.dist
}
















