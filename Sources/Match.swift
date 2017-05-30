//
//  Match.swift
//  Generator
//
//  Created by Олег on 04.05.17.
//
//

import Foundation
import Mapper

extension Date : Mappable {
    
    public typealias MappingKeys = NoKeys
    
    public init<Source>(mapper: InMapper<Source, NoKeys>) throws where Source : InMap {
        let ti = try mapper.map() as TimeInterval
        self = Date.init(timeIntervalSince1970: ti)
    }
    
    public func outMap<Destination>(mapper: inout OutMapper<Destination, NoKeys>) throws where Destination : OutMap {
        try mapper.map(self.timeIntervalSince1970)
    }
    
}

struct Match : Entity {
    
    struct ID : RawRepresentable, Hashable {
        
        let rawValue: Int
        
        init?(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        var hashValue: Int {
            return rawValue.hashValue
        }
        
        static func id(_ id: Int) -> ID {
            return ID(rawValue: id)!
        }
        
    }
    
    struct Score {
        let home: Int
        let away: Int
    }
    
    let id: Match.ID
    let home: Team.ID
    let away: Team.ID
    let date: Date
    let location: String
    let score: Score?
    
    func isPlaying(teamWithID teamID: Team.ID) -> Bool {
        return home == teamID || away == teamID
    }
    
}

func score(_ home: Int, _ away: Int) -> Match.Score {
    return Match.Score.init(home: home, away: away)
}

extension Match.Score {
    
    static func random() -> Match.Score {
        let rand1 = arc4random_uniform(10)
        let rand2 = arc4random_uniform(10)
        return score(Int(rand1), Int(rand2))
    }
    
}

extension Match {
    
    struct CompactView {
        
        let id: Match.ID
        let home: Team.MatchView
        let away: Team.MatchView
        let date: Date
        let location: String
        let score: Score?
        
    }
    
    func makeCompactView(with container: Container<Team>) -> CompactView {
        let h = container[self.home]!.makeGroupView()
        let a = container[self.away]!.makeGroupView()
        return CompactView(id: self.id, home: h, away: a, date: date, location: location, score: score)
    }
    
}

extension Match.Score : OutMappable {
    
    enum MappingKeys : String, IndexPathElement {
        case home, away
    }
    
    func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, MappingKeys>) throws {
        try mapper.map(self.home, to: .home)
        try mapper.map(self.away, to: .away)
    }
    
}

extension Match.CompactView : OutMappable {
    
    enum MappingKeys : String, IndexPathElement {
        case id, home, away, date, location, score
    }
    
    func outMap<Destination>(mapper: inout OutMapper<Destination, Match.CompactView.MappingKeys>) throws where Destination : OutMap {
        try mapper.map(self.id, to: .id)
        try mapper.map(self.home, to: .home)
        try mapper.map(self.away, to: .away)
        try mapper.map(self.date, to: .date)
        try mapper.map(self.location, to: .location)
        if let score = self.score {
            try mapper.map(score, to: .score)
        }
    }
    
}
