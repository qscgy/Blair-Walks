//
//  PathfinderModel.swift
//  Blair Walks
//



//  Created by Sam Ehrenstein on 9/24/15.
//  Copyright © 2015 MBHS Smartphone Programming Club. All rights reserved.
//

import Foundation
import Darwin
import UIKit

struct Constants {
    static let INVALID="Invalid room numbers."
}


//Model for pathfinding algorithms
class PathfinderModel{
    var map:Graph=Graph()
    var coords:[String:(Int,Int)]=[String:(Int,Int)]()
    init(file:String, coords:String){
        self.coords=initCoordsFromFile(coords)
        map=Graph(edges: initEdgesFromFile(file))
    }
    func findShortestPath(start:String,end:String)->String{
        if let _=map.graph[start]{
            if let _=map.graph[end]{ //make sure both are valid vertices
                return map.findShortestPath(start,end: end)
            } else {
                return Constants.INVALID
            }
        } else {
            return Constants.INVALID
        }
    }
    func initEdgesFromFile(file:String)->[Edge]{
        let path=NSBundle.mainBundle().pathForResource(file, ofType: "csv")
        /*
        //might be a buffered reading system, or just have a size cap (not my algorithm)
        
        let url=NSURL(fileURLWithPath: path!)
        //print(url)
        let data=NSData(contentsOfURL: url)
        //print(data)
        var inputStream:NSInputStream=NSInputStream(data: data!)
        let bufferSize=1500
        var buffer=Array<UInt8>(count: bufferSize, repeatedValue: 0)
        
        inputStream.open()
        
        var bytesRead=inputStream.read(&buffer, maxLength: bufferSize)
        var contents=NSString(bytes: &buffer, length: bytesRead, encoding: NSUTF8StringEncoding)
        var a:String=contents! as String
        var contentsArray=a.componentsSeparatedByString("\n")
        //print(contentsArray)
        inputStream.close()
        */
        
        let fileStr:String
        
        //set fileStr to be the contents of file
        do{
            try fileStr=String(contentsOfFile: path!)
        }
        catch _{
            fileStr=""
        }
        let contentsArray=fileStr.componentsSeparatedByString("\n") //split line by line
        var edges:[Edge]=[]
        
        //create an edge from each line
        for str:String in contentsArray{
            //print(str)
            print(str)
            let edgeData=str.componentsSeparatedByString(",")
            let distance=dist(coords[edgeData[0]]!, p2: coords[edgeData[1]]!)
            //print(edgeData)
            edges.append(Edge(v1: edgeData[0], v2: edgeData[1], dist:distance))
        }
        //print(edges)
        return edges
    }
}

class Edge{
    var v1:String
    var v2:String
    var dist:Double
    init(v1:String,v2:String,dist:Double){
        self.v1=v1
        self.v2=v2
        self.dist=dist
    }
}

//only used by Graph class
class Vertex:Hashable,Comparable{
    var name:String
    var dist=Double(Int.max)
    var neighbors=[Vertex:Double]()
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
    init(){
        graph=[String:Vertex]()
    }
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
    func findShortestPath(start:String,end:String)->String{
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
            
            //search neighbors for unvisited vertices or better paths
            for v:Vertex in neighbors.keys{
                let dist=current.dist+neighbors[v]!  //distance to current+distance from current to neighbor=total dist to neighbor
                if let _=cameFrom[v]{   //v has already been found
                    if v.dist>dist{  //better path
                        v.dist=dist
                        cameFrom[v]=current
                        frontier.push(Int(dist), item: v)
                    }
                } else {
                    v.dist=dist
                    cameFrom[v]=current
                    frontier.push(Int(dist), item: v)
                }
            }
        }
         return pathToString(cameFrom,end: graph[end]!)
    }
}

func pathToString(cameFrom:[Vertex: Vertex],end:Vertex)->String{
    var current=end
    var keepGoing=true
    /*
    print("\n")
    for v:Vertex in cameFrom.keys{
        print("\(v.name) \(cameFrom[v]!.name)")
    }
    print("\n")
    */
    var path:[String]=[]
    while keepGoing{
        path.append(current.name)
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
    path=path.reverse()
    print(path)
    var pathStr=""
    for str in path{
        pathStr+=str+"\n"
    }
    return pathStr
}

func drawLine(from:CGPoint,to:CGPoint){
    
}


func initCoordsFromFile(file:String)->[String:(Int,Int)]{
    let path=NSBundle.mainBundle().pathForResource(file, ofType: "csv")
    let fileStr:String
    
    //set fileStr to be the contents of file
    do{
        try fileStr=String(contentsOfFile: path!)
    }
    catch _{
        fileStr=""
    }
    let contentsArray=fileStr.componentsSeparatedByString("\n") //split line by line
    var coords:[String:(Int,Int)]=[String:(Int,Int)]()
    
    //create an edge from each line
    for str:String in contentsArray{
        //print(str)
        print(str)
        let coordData=str.componentsSeparatedByString(",")
        coords[coordData[0]]=((Int(coordData[1])!, Int(coordData[2])!))
    }
    return coords
}

func dist(p1:(Int,Int),p2:(Int,Int))->Double{
    return sqrt(pow(Double(p2.0-p1.0), 2)+pow(Double(p2.1-p1.1), 2))
}

//protocol-required operators for Vertex
func ==(left: Vertex, right: Vertex) -> Bool {
    return left.hashValue == right.hashValue
}

func <(l:Vertex,r:Vertex)->Bool{
    return l.dist<r.dist
}












