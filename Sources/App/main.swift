import Vapor
import VaporMySQL
import HTTP

let drop = Droplet(preparations: [Attendee.self], providers: [VaporMySQL.Provider.self])
drop.middleware.append(CorsMiddleware())

let _ = drop.config["app", "key"]?.string ?? ""

let attendees = AttendeeController(droplet: drop)
drop.resource("attendees", attendees)

let languages = LanguagesController(droplet: drop)
drop.resource("languages", languages)

drop.get("languages", String.self) { request, langName in
    let attendees = try Attendee.query().filter("languages", contains: langName).all()
    return try attendees.makeNode().converted(to: JSON.self)
}

let port = drop.config["app", "port"]?.int ?? 80

// Print what link to visit for default port
drop.serve()
