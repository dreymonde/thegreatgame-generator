//
//  Maps.swift
//  Generator
//
//  Created by Олег on 04.05.17.
//
//

import Foundation
import Mapper

struct ZippedMap<Mappable1 : OutMappable, Mappable2 : OutMappable> : OutMappable {
    
    let left: Mappable1
    let right: Mappable2
    
    init(left: Mappable1, right: Mappable2) {
        self.left = left
        self.right = right
    }
        
    func outMap<Destination>(mapper: inout OutMapper<Destination, NoKeys>) throws where Destination : OutMap {
        mapper.destination = try left.map(to: mapper.destination)
        mapper.destination = try right.map(to: mapper.destination)
    }
    
}

struct DivedMap<Mappable1 : OutMappable, Mappable2 : OutMappable> : OutMappable {
    
    let main: Mappable1
    let under: Mappable2
    let underKey: String
    
    typealias MappingKeys = String
    
    func outMap<Destination>(mapper: inout OutMapper<Destination, String>) throws where Destination : OutMap {
        mapper.destination = try main.map(to: mapper.destination)
        try mapper.destination.set(try under.map(), at: .key(underKey))
    }
    
}

struct ArrayMap<MappableType : OutMappable> : OutMappable {
    
    let array: [MappableType]
    let key: String
    
    typealias MappingKeys = String
    
    func outMap<Destination>(mapper: inout OutMapper<Destination, String>) throws where Destination : OutMap {
        try mapper.map(self.array, to: key)
    }
    
}
