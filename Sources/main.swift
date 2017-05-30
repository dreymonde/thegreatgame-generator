import Foundation
import CocoaMapper
import Mapper
import Shallows
import Files
import ShellOut
import Timepiece

// MARK: - Edition

let editionCache = RawFileSystemCache.init(directoryURL: FileSystemCache.inDirectory(.desktopDirectory, appending: "the-great-game-edition").directoryURL)
    .mapString()
    .mapValues(transformIn: throwing({ Int($0) }),
               transformOut: { String($0) })
    .mapKeys(RawFileSystemCache.FileName.init)
    .singleKey("edition")
    .makeSyncCache()

let edition = try editionCache.retrieve()
try editionCache.set(edition + 1)

// MARK: - Teams

let swe = Team(id: .swe,
               name: "Sweden",
               shortName: "SWE",
               rank: 5,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/3/35/Sweden_national_football_team_logo.png")!)

let ned = Team(id: .ned,
               name: "Netherlands",
               shortName: "NED",
               rank: 9,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/thumb/a/a1/Royal_Netherlands_Football_Association_Logo.svg/428px-Royal_Netherlands_Football_Association_Logo.svg.png")!)

let ger = Team(id: .ger,
               name: "Germany",
               shortName: "GER",
               rank: 1,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/thumb/e/e5/DFBWomen.svg/401px-DFBWomen.svg.png")!)

let rus = Team(id: .rus,
               name: "Russia",
               shortName: "RUS",
               rank: 15,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/7/77/Russian_Football_Union.png")!)

let ita = Team(id: .ita,
               name: "Italy",
               shortName: "ITA",
               rank: 8,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/thumb/9/97/FIGC_logo.svg/414px-FIGC_logo.svg.png")!)

let fra = Team(id: .fra,
               name: "France",
               shortName: "FRA",
               rank: 2,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/9/96/Le_nouveau_logo_FFF.png")!)

let eng = Team(id: .eng,
               name: "England",
               shortName: "ENG",
               rank: 3,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/thumb/3/38/England_crest_2009.svg/403px-England_crest_2009.svg.png")!)

let nor = Team(id: .nor,
               name: "Norway",
               shortName: "NOR",
               rank: 4,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/1/1c/Norges_Fotballforbund_-_Norway_Norge.png")!)

let esp = Team(id: .esp,
               name: "Spain",
               shortName: "ESP",
               rank: 6,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/3/31/Spain_National_Football_Team_badge.png")!)

let sui = Team(id: .sui,
               name: "Switzerland",
               shortName: "SUI",
               rank: 7,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/thumb/5/53/SFV_Logo.svg/640px-SFV_Logo.svg.png")!)

let isl = Team(id: .isl,
               name: "Iceland",
               shortName: "ISL",
               rank: 10,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/a/a5/Iceland_FA.png")!)

let sco = Team(id: .sco,
               name: "Scotland",
               shortName: "SCO",
               rank: 11,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/thumb/8/8f/Scotland_national_football_team_logo.svg/480px-Scotland_national_football_team_logo.svg.png")!)

let den = Team(id: .den,
               name: "Denmark",
               shortName: "DEN",
               rank: 12,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/thumb/4/4f/Dansk_Boldspil-Union_logo.svg/480px-Dansk_Boldspil-Union_logo.svg.png")!)

let autString = "https://upload.wikimedia.org/wikipedia/en/thumb/1/14/Österreichischer_Fußball-Bund_logo.svg/640px-Österreichischer_Fußball-Bund_logo.svg.png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
let aut = Team(id: .aut,
               name: "Austria",
               shortName: "AUT",
               rank: 13,
               badgeURL: URL.init(string: autString)!)

let bel = Team(id: .bel,
               name: "Belgium",
               shortName: "BEL",
               rank: 14,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/f/f5/Belgium_urbsfa.png")!)

let por = Team(id: .por,
               name: "Portugal",
               shortName: "POR",
               rank: 23,
               badgeURL: URL.init(string: "https://upload.wikimedia.org/wikipedia/en/thumb/5/5f/Portuguese_Football_Federation.svg/359px-Portuguese_Football_Federation.svg.png")!)

// MARK: - Group A Matches

let ned_nor = Match(id: .id(1),
                    home: .ned, away: .nor,
                    date: .july2017(day: 16, hour: 18, minute: 00),
                    location: "Stadion Galgenwaard, Utrecht",
                    score: nil)
let den_bel = Match(id: .id(2),
                    home: .den, away: .bel,
                    date: .july2017(day: 16, hour: 20, minute: 45),
                    location: "De Vijverberg, Doetinchem",
                    score: nil)
let nor_bel = Match(id: .id(9),
                    home: .nor, away: .bel,
                    date: .july2017(day: 20, hour: 18, minute: 00),
                    location: "Rat Verlegh Stadion, Breda",
                    score: nil)
let ned_den = Match(id: .id(10),
                    home: .ned, away: .den,
                    date: .july2017(day: 20, hour: 20, minute: 45),
                    location: "Sparta Stadion Het Kasteel, Rotterdam",
                    score: nil)
let bel_ned = Match(id: .id(17),
                    home: .bel, away: .ned,
                    date: .july2017(day: 24, hour: 20, minute: 45),
                    location: "Koning Willem II Stadion, Tilburg",
                    score: nil)
let nor_den = Match(id: .id(18),
                    home: .nor, away: .den,
                    date: .july2017(day: 24, hour: 20, minute: 45),
                    location: "De Adelaarshorst, Deventer",
                    score: nil)

// MARK: - Group B Matches

let ita_rus = Match(id: .id(3),
                    home: .ita, away: .rus,
                    date: .july2017(day: 17, hour: 18, minute: 00),
                    location: "Sparta Stadion Het Kasteel, Rotterdam",
                    score: nil)

let ger_swe = Match(id: .id(4),
                    home: .ger, away: .swe,
                    date: .july2017(day: 17, hour: 20, minute: 45),
                    location: "Rat Verlegh Stadion, Breda",
                    score: nil)

let swe_rus = Match(id: .id(11),
                    home: .swe, away: .rus,
                    date: .july2017(day: 21, hour: 18, minute: 00),
                    location: "De Adelaarshorst, Deventer",
                    score: nil)

let ger_ita = Match(id: .id(12),
                    home: .ger, away: .ita,
                    date: .july2017(day: 21, hour: 20, minute: 45),
                    location: "Koning Willem II Stadion, Tilburg",
                    score: nil)

let rus_ger = Match(id: .id(19),
                    home: .rus, away: .ger,
                    date: .july2017(day: 25, hour: 20, minute: 45),
                    location: "Stadion Galgenwaard, Utrecht",
                    score: nil)

let swe_ita = Match(id: .id(20),
                    home: .swe, away: .ita,
                    date: .july2017(day: 25, hour: 20, minute: 45),
                    location: "De Vijverberg, Doetinchem",
                    score: nil)

// MARK: - Group C Matches

let aut_sui = Match(id: .id(5),
                    home: .aut, away: .sui,
                    date: .july2017(day: 18, hour: 18, minute: 00),
                    location: "De Adelaarshorst, Deventer",
                    score: nil)

let fra_isl = Match(id: .id(6),
                    home: .fra, away: .isl,
                    date: .july2017(day: 18, hour: 20, minute: 45),
                    location: "Koning Willem II Stadion, Tilburg",
                    score: nil)

let isl_sui = Match(id: .id(13),
                    home: .isl, away: .sui,
                    date: .july2017(day: 22, hour: 18, minute: 00),
                    location: "De Vijverberg, Doetinchem",
                    score: nil)

let fra_aut = Match(id: .id(14),
                    home: .fra, away: .aut,
                    date: .july2017(day: 22, hour: 20, minute: 45),
                    location: "Stadion Galgenwaard, Utrecht",
                    score: nil)

let sui_fra = Match(id: .id(21),
                    home: .sui, away: .fra,
                    date: .july2017(day: 26, hour: 20, minute: 45),
                    location: "Rat Verlegh Stadion, Breda",
                    score: nil)

let isl_aut = Match(id: .id(22),
                    home: .isl, away: .aut,
                    date: .july2017(day: 26, hour: 20, minute: 45),
                    location: "Sparta Stadion Het Kasteel, Rotterdam",
                    score: nil)

// MARK: - Group D Matches

let esp_por = Match(id: .id(7),
                    home: .esp, away: .por,
                    date: .july2017(day: 19, hour: 18, minute: 00),
                    location: "De Vijverberg, Doetinchem",
                    score: nil)

let eng_sco = Match(id: .id(8),
                    home: .eng, away: .sco,
                    date: .july2017(day: 19, hour: 20, minute: 45),
                    location: "Stadion Galgenwaard, Utrecht",
                    score: nil)

let sco_por = Match(id: .id(15),
                    home: .sco, away: .por,
                    date: .july2017(day: 23, hour: 18, minute: 00),
                    location: "Sparta Stadion Het Kasteel, Rotterdam",
                    score: nil)

let eng_esp = Match(id: .id(16),
                    home: .eng, away: .esp,
                    date: .july2017(day: 23, hour: 20, minute: 45),
                    location: "Rat Verlegh Stadion, Breda",
                    score: nil)

let por_eng = Match(id: .id(23),
                    home: .por, away: .eng,
                    date: .july2017(day: 27, hour: 20, minute: 45),
                    location: "Koning Willem II Stadion, Tilburg",
                    score: nil)

let sco_esp = Match(id: .id(24),
                    home: .sco, away: .esp,
                    date: .july2017(day: 27, hour: 20, minute: 45),
                    location: "De Adelaarshorst, Deventer",
                    score: nil)

// MARK: - Groups

let groupA = Group(id: .a,
                   name: "Group A",
                   teams: [(.ned, groupstat(points: 0)),
                           (.nor, groupstat(points: 0)),
                           (.den, groupstat(points: 0)),
                           (.bel, groupstat(points: 0))],
                   matches: [.id(1), .id(2), .id(9), .id(10), .id(17), .id(18)])

let groupB = Group(id: .b,
                   name: "Group B",
                   teams: [(.ger, groupstat(points: 0)),
                           (.swe, groupstat(points: 3)),
                           (.ita, groupstat(points: 3)),
                           (.rus, groupstat(points: 0))],
                   matches: [.id(3), .id(4), .id(11), .id(12), .id(19), .id(20)])

let groupC = Group(id: .c,
                   name: "Group C",
                   teams: [(.fra, groupstat(points: 0)),
                           (.isl, groupstat(points: 0)),
                           (.aut, groupstat(points: 0)),
                           (.sui, groupstat(points: 0))],
                   matches: [.id(5), .id(6), .id(13), .id(14), .id(21), .id(22)])

let groupD = Group(id: .d,
                   name: "Group D",
                   teams: [(.eng, groupstat(points: 0)),
                           (.sco, groupstat(points: 0)),
                           (.esp, groupstat(points: 0)),
                           (.por, groupstat(points: 0))],
                   matches: [.id(7), .id(8), .id(15), .id(16), .id(23), .id(24)])

let stages = (groupA.makeStages() + groupB.makeStages() + groupC.makeStages() + groupD.makeStages()).sorted(by: { $0.order < $1.order })

let teamsContainer = [swe, ned, ger, rus, ita, fra, eng, nor, esp, sui, isl, sco, den, aut, bel, por].makeContainer()
let groupsContainer = [groupA, groupB, groupC, groupD].makeContainer()
let matchesContainer = [
    ned_nor,
    den_bel,
    nor_bel,
    ned_den,
    bel_ned,
    nor_den,
    ita_rus,
    ger_swe,
    swe_rus,
    ger_ita,
    rus_ger,
    swe_ita,
    aut_sui,
    fra_isl,
    isl_sui,
    fra_aut,
    sui_fra,
    isl_aut,
    esp_por,
    eng_sco,
    sco_por,
    eng_esp,
    por_eng,
    sco_esp,
].makeContainer()

let emptyStat = Group.Stat(points: 0)

let fs = FileSystem()

let currentFolder = fs.currentFolder
let teamsFolder = try currentFolder.subfolder(named: "teams")

let rawTeams = RawFileSystemCache(directoryURL: URL(fileURLWithPath: teamsFolder.path))
let jsonTeamsCache: SyncCache<String, [String : Any]> = rawTeams.syncJSONCache()

let teams = Teams(teams: teamsContainer.values.map({ $0.makeCompactView() })).withEdition(edition)
try jsonTeamsCache.set(try teams.map(), forKey: "all.json")
for team in teamsContainer.values {
    let teamFull = team.makeFullView(matchesContainer: matchesContainer, groupsContainer: groupsContainer, teamsContainer: teamsContainer).withEdition(edition)
    let json = try teamFull.map() as [String : Any]
    try jsonTeamsCache.set(json, forKey: "\(team.id.rawValue).json")
}

let groupsFolder = try currentFolder.subfolder(named: "groups")

let rawGroups = RawFileSystemCache(directoryURL: URL.init(fileURLWithPath: groupsFolder.path))
let jsonGroupsCache = rawGroups.syncJSONCache()

for group in groupsContainer.values {
    let groupView = group.makeFullView(matchContainer: matchesContainer, teamContainer: teamsContainer).withEdition(edition)
    let groupJSON = try groupView.map() as [String : Any]
    try jsonGroupsCache.set(groupJSON, forKey: "\(group.id.rawValue).json")
}
let allGroupsJSON = try ArrayMap(array: groupsContainer.values.sorted(by: { $0.id.rawValue < $1.id.rawValue }).map({ $0.makeTableView(with: teamsContainer) }), key: "groups").withEdition(edition).map() as [String : Any]
try jsonGroupsCache.set(allGroupsJSON, forKey: "all.json")

let matchesFolder = try currentFolder.subfolder(named: "matches")

let rawMatches = RawFileSystemCache(directoryURL: URL.init(fileURLWithPath: matchesFolder.path))
let jsonMatchesCache = rawMatches.syncJSONCache()

let allMatchesJSON = try ArrayMap(array: matchesContainer.values.sorted(by: { $0.id.rawValue < $1.id.rawValue }).map({ $0.makeCompactView(with: teamsContainer) }), key: "matches").withEdition(edition).map() as [String : Any]
try jsonMatchesCache.set(allMatchesJSON, forKey: "all.json")

let allStagesJSON = try ArrayMap(array: stages.map({ $0.makeView(matchContainer: matchesContainer, teamContainer: teamsContainer) }), key: "stages")
    .withEdition(edition)
    .map() as [String : Any]
try jsonMatchesCache.set(allStagesJSON, forKey: "stages.json")
