//
//  TeamFull.swift
//  TheGreatGame
//
//  Created by Олег on 04.05.17.
//  Copyright © 2017 The Great Game. All rights reserved.
//

import Foundation
import Mapper

public struct Team {
    
    public let id: ID
    public let name: String
    public let shortName: String
    public let rank: Int
    public let badgeURL: URL
    
}

extension Team {
    
    func makeCompactView() -> CompactView {
        return CompactView(id: self.id, name: self.name, shortName: self.shortName, rank: self.rank, badgeURL: self.badgeURL)
    }
    
    func makeGroupView() -> GroupView {
        return GroupView(id: self.id, name: self.name, badgeURL: self.badgeURL, shortName: self.shortName)
    }
    
    func makeFullView(matchesContainer: Container<Match>, groupsContainer: Container<Group>, teamsContainer: Container<Team>) -> FullView {
        let group = groupsContainer.values.first(where: { $0.teamIDs.contains(self.id) })!.makeTableView(with: teamsContainer)
        let matches = matchesContainer.values
            .filter({ $0.isPlaying(teamWithID: self.id) })
            .sorted(by: { $0.id.rawValue < $1.id.rawValue })
            .map({ $0.makeCompactView(with: teamsContainer) })
        return FullView(id: self.id,
                        name: self.name,
                        shortName: self.shortName,
                        rank: self.rank,
                        badgeURL: self.badgeURL,
                        group: group,
                        matches: matches)
    }
    
}

extension Team : Mappable {
    
    public enum MappingKeys : String, IndexPathElement {
        case name
        case short_name
        case id
        case rank
        case badge_url
        case group
        case matches
    }
    
    public init<Source : InMap>(mapper: InMapper<Source, MappingKeys>) throws {
        self.name = try mapper.map(from: .name)
        self.shortName = try mapper.map(from: .short_name)
        self.id = try mapper.map(from: .id)
        self.rank = try mapper.map(from: .rank)
        self.badgeURL = try mapper.map(from: .badge_url)
    }
    
    public func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, MappingKeys>) throws {
        try mapper.map(self.name, to: .name)
        try mapper.map(self.shortName, to: .short_name)
        try mapper.map(self.id, to: .id)
        try mapper.map(self.rank, to: .rank)
        try mapper.map(self.badgeURL, to: .badge_url)
    }
    
}
