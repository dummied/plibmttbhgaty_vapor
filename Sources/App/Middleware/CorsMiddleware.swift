import Vapor
import HTTP

class CorsMiddleware: Middleware {

	func respond(to request: Request, chainingTo chain: Responder) throws -> Response {

        let response = try chain.respond(to: request)

        for header in request.headers{
            if header.key.key == "Origin" {
                response.headers["Access-Control-Allow-Origin"] = header.value
            }
            if header.key.key == "Access-Control-Request-Headers" {
                response.headers["Access-Control-Allow-Headers"] = header.value
            }
        }

        return response

	}

}
