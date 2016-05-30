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
    static let INVALID=[Vertex(name: "Invalid")]
}


//Model for pathfinding algorithms
class PathfinderModel{
    var map:Graph=Graph()
    var coords:[String:(Int,Int)]=[String:(Int,Int)]()
    var edges:[Edge]=[]
    init(file:String, coords:String){
        self.coords=initCoordsFromFile(coords)
        self.edges=initEdgesFromFile(file)
        map=Graph(edges: edges)
    }
    func findShortestPath(start:String,end:String)->[Vertex]{
        if let _=map.graph[start]{
            if let _=map.graph[end]{ //make sure both are valid vertices
                return map.findShortestPath(start,end: end)
            } else {
                return []
            }
        } else {
            return []
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
            //print(coords[edgeData[0]])
            //print(coords[edgeData[1]])
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
    func findShortestPath(start:String,end:String)->[Vertex]{
        let source=graph[start]
        var cameFrom=[Vertex: Vertex]()
        cameFrom[source!]=source!
        var frontier=PriorityQueue<Vertex>(ascending: true)
        frontier.push(source!)
        source!.dist=0
        
        var current:Vertex=source!
        while !frontier.isEmpty{
            current=frontier.pop()!
            if(current.name==end){
                break
            }
            var neighbors=current.neighbors
            
            //search neighbors for unvisited vertices or better paths
            for v:Vertex in neighbors.keys{
                let dist=current.dist+neighbors[v]!  //distance to current+distance from current to neighbor=total dist to neighbor
                if let _=cameFrom[v]{   //v has already been found
                    if dist<v.dist{  //better path to v
                        v.dist=dist
                        cameFrom[v]=current
                        frontier.push(v)
                    }
                } else {
                    v.dist=dist
                    cameFrom[v]=current
                    frontier.push(v)
                }
            }
        }
        
        //go back through cameFrom to find the path
        var path:[Vertex]=[current]
        var last=cameFrom[current]
        repeat {
            path.append(last!)
            last=cameFrom[last!]
        } while last != source!
        return path.reverse()
    }
}

func pathToString(path:[Vertex])->String{
    var pathStr:String=""
    for v in path{
        pathStr += v.name+"\n"
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












