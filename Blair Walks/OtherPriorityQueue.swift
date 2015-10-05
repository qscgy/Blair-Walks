

class Node {}

class OtherPriorityQueue<T> {
    var heap = Array<(Int, T)>()
    
    func push(priority: Int, item: T) {
        heap.append((priority, item))
        
        if heap.count == 1 {
            return
        }
        
        var current = heap.count - 1
        while current > 0 {
            var parent = (current - 1) >> 1
            if heap[parent].0 <= heap[current].0 {
                break
            }
            (heap[parent], heap[current]) = (heap[current], heap[parent])
            current = parent
        }
    }
    
    func pop() -> (Int, T) {
        (heap[0], heap[heap.count - 1]) = (heap[heap.count - 1], heap[0])
        var pop = heap.removeLast()
        heapify(0)
        return pop
    }
    
    func heapify(index: Int) {
        var left = index * 2 + 1
        var right = index * 2 + 2
        var smallest = index
        
        if left < heap.count && heap[left].0 < heap[smallest].0 {
            smallest = left
        }
        if right < heap.count && heap[right].0 < heap[smallest].0 {
            smallest = right
        }
        if smallest != index {
            (heap[index], heap[smallest]) = (heap[smallest], heap[index])
            heapify(smallest)
        }
    }
    
    var count: Int {
        get {
            return heap.count
        }
    }
    
    func isEmpty()->Bool{
        return heap.count==0
    }
}


