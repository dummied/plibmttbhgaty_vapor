import Vapor
import HTTP
import Foundation

final class LanguagesController: ResourceRepresentable {
    
    let drop: Droplet
    init(droplet: Droplet) {
        drop = droplet
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        let attendees = try Attendee.all()
        let language_arr = attendees.flatMap{ $0.languages.components(separatedBy: ",") }
        let languages = Array(Set(language_arr.map{$0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)})).filter { $0 != "" }
        return try JSON(node: languages)
    }
    
    
    func makeResource() -> Resource<Attendee> {
        return Resource(
            index: index
        )
    }
}

