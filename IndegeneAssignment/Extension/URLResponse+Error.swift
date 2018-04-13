import Foundation

extension URLResponse {
    func isHttpResponseValid() -> Bool {
        guard let httpResponse = self as? HTTPURLResponse ,(200...299).contains(httpResponse.statusCode) else {
            return false
        }
        return true
    }
}

