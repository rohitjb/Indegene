import Foundation

extension URL {
    func uniqueComponent() -> String? {
        guard let queryString = self.query else { return nil }
        let queryArray = queryString.components(separatedBy: "=")
        if queryArray.count > 1 { return queryArray[1] } else { return nil }
    }
}
