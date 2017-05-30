//
//  Stage.swift
//  Generator
//
//  Created by Олег on 10.05.17.
//
//

import Mapper
import Foundation

struct Stage {
    
    let order: Int
    let title: String
    let matches: [Match.ID]
    
}

extension Stage {
    
    struct View {
        
        let title: String
        let matches: [Match.CompactView]
        
    }
    
    func makeView(matchContainer: Container<Match>, teamContainer: Container<Team>) -> View {
        let matchsView: [Match.CompactView] = matches.flatMap({ id in
            return matchContainer[id]!.makeCompactView(with: teamContainer)
        })
        return View(title: self.title,
                    matches: matchsView)
    }
    
}

extension Stage.View : OutMappable {
    
    enum MappingKeys : String, IndexPathElement {
        case title, matches
    }
    
    func outMap<Destination>(mapper: inout OutMapper<Destination, Stage.View.MappingKeys>) throws where Destination : OutMap {
        try mapper.map(self.title, to: .title)
        try mapper.map(self.matches, to: .matches)
    }
    
}
