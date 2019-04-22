//
//  LRUCache.swift
//  TubiCodingChallenge
//
//  Created by Mitali Kulkarni on 4/21/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import Foundation

class LRUCache<KEY: Hashable, VALUE> {
    
    // MARK: - Doubly LinkedList Node
    class LinkNode<KEY, VALUE> {
        var key: KEY
        var value: VALUE
        var next: LinkNode?
        var prev: LinkNode?
        
        init(_ key: KEY, _ value: VALUE) {
            self.key = key
            self.value = value
        }
    }
    
    let capacity: Int
    // The number of values currently being stored
    private var usage = 0
    private var elements = [KEY: LinkNode<KEY, VALUE>]()
    // The most recently used node
    private var head: LinkNode<KEY, VALUE>?
    // The least recently used node
    private var tail: LinkNode<KEY, VALUE>?
    
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    // MARK: - get: get one item based on key from cache
    func get(_ key: KEY) -> VALUE? {
        if (isValid(key)) {
            let node = elements[key]!
            updateUsage(of: node)
            return node.value
        }
        return nil
    }
    
    // MARK: - Update the node
    // Moves `node` to the head of the usage list
    private func updateUsage(of node: LinkNode<KEY, VALUE>) {

        if let next = node.next {
            node.next = nil
            next.prev = nil
            
            if let prev = node.prev {
                node.prev = nil
                prev.next = next
                next.prev = prev
            }
            else if self.tail === node {
                self.tail = next
            }
            
            if let head = self.head {
                node.prev = head
                head.next = node
            }
            
            head = node
        }
    }
    
    // MARK: - add: add one item to cache
    func add(_ key: KEY, _ value: VALUE) {
        // Key already exists
        if let existing = elements[key] {
            existing.value = value
            updateUsage(of: existing)
        }
            // Add new key
        else if usage < capacity {
            let node = LinkNode(key, value)
            elements[key] = node
            if let head = self.head {
                head.next = node
                node.prev = head
                self.head = node
            }
            else {
                self.head = node
            }
            if tail == nil {
                tail = node
            }
            usage += 1
        }
            // Replace least-used key
        else if let tail = self.tail {
            elements[tail.key] = nil
            tail.key = key
            tail.value = value
            elements[key] = tail
            updateUsage(of: tail)
        }
    }
    
    // MARK: - isValid: check if a item is still valid based on the key
    func isValid(_ key: KEY) -> Bool {
         if let _ = elements[key] {
            return true
        }
        return false
    }
}
