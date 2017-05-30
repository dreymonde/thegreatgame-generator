//
//  Editioned.swift
//  TheGreatGame
//
//  Created by Олег on 03.05.17.
//  Copyright © 2017 The Great Game. All rights reserved.
//

import Mapper

public struct Editioned<Content : OutMappable> {
    
    public let edition: Int
    public let content: Content
    
    public func isMoreRecent(than other: Editioned<Content>) -> Bool {
        if self.edition == -1 && other.edition != -1 {
            return true
        } else {
            return self.edition > other.edition
        }
    }
    
    public static func compare(_ lhs: Editioned<Content>, _ rhs: Editioned<Content>) -> Bool {
        return lhs.isMoreRecent(than: rhs)
    }
    
}

public enum EditionedMappingKeys : String, IndexPathElement {
    case edition, content
}

extension Editioned : OutMappable {
    
    public func outMap<Destination>(mapper: inout OutMapper<Destination, EditionedMappingKeys>) throws where Destination : OutMap {
        try mapper.map(self.edition, to: .edition)
        try mapper.map(self.content, to: .content)
    }
    
}

extension OutMappable {
    
    func withEdition(_ edition: Int) -> Editioned<Self> {
        return Editioned(edition: edition, content: self)
    }
    
}
