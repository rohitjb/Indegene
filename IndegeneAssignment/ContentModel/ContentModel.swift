import Foundation

enum KeyError: Error {
    case keyDoesNotMatch
}

enum Type: String {
    case image
    case pdf
    case video
}

enum ContentType {
    case image(String)
    case pdf(String)
    case video(String)
}

protocol JsonInitialiable {
    init(json: Json) throws
}

struct Content: JsonInitialiable {
    let contentType: ContentType
    
    init(json: Json) throws {
        
        guard let typeSring = json["type"] as? String,
            let type = Type(rawValue: typeSring),
            let url = json["url"] as? String else {
            throw KeyError.keyDoesNotMatch
        }

        switch type {
        case .image:
            contentType = .image(url)
        case .pdf:
            contentType = .pdf(url)
        case .video:
            contentType = .video(url)
        }
    }
}
