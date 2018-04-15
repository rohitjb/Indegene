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
    
    func url() -> String {
        switch self {
        case .image(let url):
            return url
        case .pdf(let url):
            return url
        case .video(let url):
            return url
        }
    }
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

extension Content: Equatable {
    static func ==(lhs: Content, rhs: Content) -> Bool {
        return lhs.contentType == rhs.contentType
    }
}

extension ContentType: Equatable {
    static func ==(lhs: ContentType, rhs: ContentType) -> Bool {
        switch (lhs, rhs) {
        case (let .image(url1), let .image(url2)):
            return url1 == url2
        case (let .pdf(url1), let .pdf(url2)):
            return url1 == url2
        case (let .video(url1), let .video(url2)):
            return url1 == url2
        default:
            return false
        }
    }
}
