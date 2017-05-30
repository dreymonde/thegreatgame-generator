//
//  Team.swift
//  TheGreatGame
//
//  Created by Олег on 03.05.17.
//  Copyright © 2017 The Great Game. All rights reserved.
//

import Mapper
import Foundation

protocol Entity {
    
    associatedtype ID : Hashable
    
    var id: ID { get }
    
}

typealias Container<Value : Entity> = [Value.ID : Value]

extension Team : Entity {
    
    public enum ID : Int {
        case swe = 1, ned, ger, rus, ita, fra, eng, nor, esp, sui, isl, sco, den, aut, bel, por
        
        func team(in container: Container<Team>) -> Team? {
            return container[self]
        }
    }
    
}

extension Team {

    public struct CompactView {
        
        public let id: ID
        public let name: String
        public let shortName: String
        public let rank: Int
        public let badgeURL: URL
        
    }
    
    public struct GroupView {
        
        public let id: ID
        public let name: String
        public let badgeURL: URL
        public let shortName: String
        
    }
    
    public typealias MatchView = GroupView
    
    struct FullView {
        
        let id: ID
        let name: String
        let shortName: String
        let rank: Int
        let badgeURL: URL
        let group: Group.TableView
        let matches: [Match.CompactView]
        
    }
    
}

extension Team.CompactView : Mappable {
    
    public init<Source : InMap>(mapper: InMapper<Source, Team.MappingKeys>) throws {
        self.name = try mapper.map(from: .name)
        self.shortName = try mapper.map(from: .short_name)
        self.id = try mapper.map(from: .id)
        self.rank = try mapper.map(from: .rank)
        self.badgeURL = try mapper.map(from: .badge_url)
    }
    
    public func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, Team.MappingKeys>) throws {
        try mapper.map(self.name, to: .name)
        try mapper.map(self.shortName, to: .short_name)
        try mapper.map(self.id, to: .id)
        try mapper.map(self.rank, to: .rank)
        try mapper.map(self.badgeURL, to: .badge_url)
    }
    
}

extension Team.GroupView : Mappable {
    
    public init<Source : InMap>(mapper: InMapper<Source, Team.MappingKeys>) throws {
        self.name = try mapper.map(from: .name)
        self.id = try mapper.map(from: .id)
        self.badgeURL = try mapper.map(from: .badge_url)
        self.shortName = try mapper.map(from: .short_name)
    }
    
    public func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, Team.MappingKeys>) throws {
        try mapper.map(self.name, to: .name)
        try mapper.map(self.id, to: .id)
        try mapper.map(self.badgeURL, to: .badge_url)
        try mapper.map(self.shortName, to: .short_name)
    }
    
}

extension Team.FullView : OutMappable {
    
    public func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, Team.MappingKeys>) throws {
        try mapper.map(self.name, to: .name)
        try mapper.map(self.shortName, to: .short_name)
        try mapper.map(self.id, to: .id)
        try mapper.map(self.badgeURL, to: .badge_url)
        try mapper.map(self.rank, to: .rank)
        try mapper.map(self.group, to: .group)
        try mapper.map(self.matches, to: .matches)
    }
    
}

public struct Teams {
    
    public var teams: [Team.CompactView]
    
}

extension Teams : Mappable {
    
    public enum MappingKeys : String, IndexPathElement {
        case teams
    }
    
    public init<Source : InMap>(mapper: InMapper<Source, MappingKeys>) throws {
        self.teams = try mapper.map(from: .teams)
    }
    
    public func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, MappingKeys>) throws {
        try mapper.map(self.teams, to: .teams)
    }
    
}
