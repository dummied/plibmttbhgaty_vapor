import Vapor
import HTTP

final class AttendeeController: ResourceRepresentable {
    typealias Item = Attendee

    let drop: Droplet
    init(droplet: Droplet) {
        drop = droplet
    }

    func index(request: Request) throws -> ResponseRepresentable {
        return try Attendee.all().makeNode().converted(to: JSON.self)
    }

    func store(request: Request) throws -> ResponseRepresentable {
        var attendee = Attendee(
                        id: nil,
                        name: request.data["name"]?.string ?? "",
                        bio: request.data["bio"]?.string ?? "",
                        languages: request.data["languages"]?.string ?? ""
                       )
        try attendee.save()
        return attendee
    }


    func show(request: Request, item attendee: Attendee) throws -> ResponseRepresentable {
        //User can be used like JSON with JsonRepresentable
        return try JSON(node: [
            "controller": "AttendeeController.show",
            "attendee": attendee
        ])
    }


    func makeResource() -> Resource<Attendee> {
        return Resource(
            index: index,
            store: store,
            show: show
        )
    }
}
