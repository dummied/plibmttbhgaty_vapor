import Vapor
import Fluent

// MARK: Model

struct Attendee: Model {
    var id: Node?
    
    var name: String
    var bio: String
    var languages: String
}

// MARK: NodeConvertible

extension Attendee: NodeConvertible {
    init(node: Node, in context: Context) throws {
        id = node["id"]
        name = node["name"]?.string ?? ""
        bio = node["bio"]?.string ?? ""
        languages = node["languages"]?.string ?? ""
    }
    
    func makeNode() throws -> Node {
        return try Node.init(node:
            [
                "id": id,
                "name": name,
                "bio": bio,
                "languages": languages
            ]
        )
    }
}

// MARK: Database Preparations

extension Attendee: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create("attendees") { users in
            users.id()
            users.string("name")
            users.string("bio", optional: true)
            users.string("languages", optional: true)
        }
    }
    
    static func revert(_ database: Database) throws {
        fatalError("unimplemented \(#function)")
    }
}
