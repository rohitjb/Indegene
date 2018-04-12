import Foundation

enum Type {
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
    init(json: Json)
}

struct Content: JsonInitialiable {
    init(json: Json) {
        
    }
}
