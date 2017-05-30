//
//  Extensions.swift
//  Generator
//
//  Created by Олег on 04.05.17.
//
//

import Foundation
import Mapper
import Shallows

extension URL : Mappable {
    
    public init<Source>(mapper: PlainInMapper<Source>) throws where Source : InMap {
        let urlString: String = try mapper.map()
        if let url = URL(string: urlString) {
            self = url
        } else {
            throw URLError(.badURL)
        }
    }
    
    public func outMap<Destination>(mapper: inout OutMapper<Destination, NoKeys>) throws where Destination : OutMap {
        try mapper.map(self.absoluteString)
    }
    
}

extension Sequence where Iterator.Element : Entity {
    
    func makeContainer() -> Container<Iterator.Element> {
        var container = Container<Iterator.Element>()
        for element in self {
            container[element.id] = element
        }
        return container
    }
    
}

extension RawFileSystemCache {
    
    func syncJSONCache() -> SyncCache<String, [String : Any]> {
        return self.mapKeys(RawFileSystemCache.FileName.init)
            .mapJSONDictionary()
            .makeSyncCache()
    }
    
}

extension Date {
    
    static func year2017(_ month: Int, day: Int, hour: Int, minute: Int) -> Date {
        var amsterdamCalendar = Calendar.current
        amsterdamCalendar.timeZone = TimeZone(identifier: "Europe/Amsterdam")!
        return Date.init(era: nil, year: 2017, month: month, day: day, hour: hour, minute: minute, second: 0, nanosecond: 0, on: amsterdamCalendar)
    }
    
    static func july2017(day: Int, hour: Int, minute: Int) -> Date {
        return .year2017(7, day: day, hour: hour, minute: minute)
    }
    
    static func augt2017(day: Int, hour: Int, minute: Int) -> Date {
        return .year2017(8, day: day, hour: hour, minute: minute)
    }
    
}
