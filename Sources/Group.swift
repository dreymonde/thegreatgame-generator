//
//  Group.swift
//  Generator
//
//  Created by Олег on 04.05.17.
//
//

import Foundation
import Mapper

func groupstat(points: Int) -> Group.Stat {
    return Group.Stat(points: points)
}

struct Group {
    
    struct Stat {
        let points: Int
    }
    
    let id: ID
    let name: String
    let teams: [(Team.ID, Stat)]
    let matches: [Match.ID]
    
    var teamIDs: [Team.ID] {
        return teams.map({ $0.0 })
    }
    
    func makeTableView(with container: Container<Team>) -> TableView {
        let teamsView: [(Team.GroupView, Stat)] = teams.flatMap { (id, stat) in
            if let view = id.team(in: container)?.makeGroupView() {
                return (view, stat)
            }
            return nil
        }
        return TableView(id: self.id, name: self.name, teams: teamsView.map({ view, stat in ZippedMap<Team.GroupView, Stat>.init(left: view, right: stat) }))
    }
    
    func makeScheduleView(matchContainer: Container<Match>, teamContainer: Container<Team>) -> ScheduleView {
        let matchsView: [Match.CompactView] = matches.flatMap({ id in
            return matchContainer[id]!.makeCompactView(with: teamContainer)
        })
        return ScheduleView(id: self.id, name: self.name, matches: matchsView)
    }
    
    func makeFullView(matchContainer: Container<Match>, teamContainer: Container<Team>) -> FullView {
        return FullView(id: id,
                        name: name,
                        teams: makeTableView(with: teamContainer).teams,
                        matches: makeScheduleView(matchContainer: matchContainer, teamContainer: teamContainer).matches)
    }
    
    func makeStages() -> [Stage] {
        guard matches.count == 6 else {
            return []
        }
        let stage1 = Stage(order: self.id.rawValue,
                           title: "\(self.name), leg 1",
            matches: [matches[0], matches[1]])
        let stage2 = Stage(order: self.id.rawValue + 4,
                           title: "\(self.name), leg 2",
            matches: [matches[2], matches[3]])
        let stage3 = Stage(order: self.id.rawValue + 8,
                           title: "\(self.name), leg 3",
            matches: [matches[4], matches[5]])
        return [stage1, stage2, stage3]
    }
    
    struct TableView {
        
        let id: Group.ID
        let name: String
        let teams: [ZippedMap<Team.GroupView, Stat>]
        
    }
    
    struct ScheduleView {
        
        let id: Group.ID
        let name: String
        let matches: [Match.CompactView]
        
    }
    
    struct FullView {
        
        let id: Group.ID
        let name: String
        let teams: [ZippedMap<Team.GroupView, Stat>]
        let matches: [Match.CompactView]

    }
    
}

extension Group : Entity {
    
    enum ID : Int {
        case a = 1, b, c, d
    }
    
}

extension Group.Stat : Mappable {
    
    enum MappingKeys : String, IndexPathElement {
        case points
    }
    
    init<Source : InMap>(mapper: InMapper<Source, MappingKeys>) throws {
        self.points = try mapper.map(from: .points)
    }
    
    func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, MappingKeys>) throws {
        try mapper.map(self.points, to: .points)
    }
    
}

extension Group.TableView : OutMappable {
    
    enum MappingKeys : String, IndexPathElement {
        case title, teams, id
    }
        
    func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, MappingKeys>) throws {
        try mapper.map(self.name, to: .title)
        try mapper.map(self.teams, to: .teams)
        try mapper.map(self.id, to: .id)
    }
    
}

extension Group.ScheduleView : OutMappable {
    
    enum MappingKeys : String, IndexPathElement {
        case title, id, matches
    }
    
    func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, MappingKeys>) throws {
        try mapper.map(self.id, to: .id)
        try mapper.map(self.name, to: .title)
        try mapper.map(self.matches, to: .matches)
    }
    
}

extension Group.FullView : OutMappable {
    
    enum MappingKeys : String, IndexPathElement {
        case title, id, matches, teams
    }
    
    func outMap<Destination : OutMap>(mapper: inout OutMapper<Destination, MappingKeys>) throws {
        try mapper.map(self.id, to: .id)
        try mapper.map(self.name, to: .title)
        try mapper.map(self.matches, to: .matches)
        try mapper.map(self.teams, to: .teams)
    }
    
}
