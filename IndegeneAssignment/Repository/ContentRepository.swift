import Foundation

typealias Json = [String: Any]

enum JSONLoaderError: Error {
    case loadJSONFileError(message: String)
    case parseJSONError(message: String)
}

protocol ContentRepository {
    func loadJSON(name: String) throws -> Json
}

class IndgeneContentRepository: ContentRepository {
    
    func loadJSON(name: String) throws -> Json {
        let data = try loadFile(name: name, ofType: "json")
        guard let json = (try JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {
            throw JSONLoaderError.parseJSONError(message: "Couldn't parse JSON file named \(name).json")
        }
        return json
    }

    private func loadFile(name: String,
                          ofType type: String) throws -> Data {
        
        let bundle = Bundle.main
        guard let path = bundle.path(forResource: name, ofType: type),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                let message: String
                if let bundleIdentifier = bundle.bundleIdentifier {
                    message = "Couldn't load file named \(name).\(type) in bundle \(bundleIdentifier)"
                } else {
                    message = "Couldn't load file named \(name).\(type)"
                }
                throw JSONLoaderError.loadJSONFileError(message: message)
        }
        return data
    }
}
