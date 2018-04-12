import Foundation
import UIKit

enum DataError: Error {
    case notCorrectResponse
    case dataUnavailable
    case notValidUrl
}

protocol DataFetcher {
    func loadData(urlString: String, completionHandler: @escaping (Data?) -> Void)
}

class IndengeDataFetcher: NSObject, DataFetcher, URLSessionDelegate {
    let urlSessionFactory: URLSessionFactory

    init(urlSessionFactory: URLSessionFactory) {
        self.urlSessionFactory = urlSessionFactory
    }
    
    func loadData(urlString: String, completionHandler: @escaping (Data?) -> Void) {
        guard let url = urlString.urlFromString() else {
            return
        }
        
        let session = urlSessionFactory.makeSession(with: self)
        let backgroundTask = session.dataTask(with: url) {[unowned self] (data, response, error) in
            if self.checkIfResponseIsCorrect(response: response, error: error) {
                completionHandler(data)
            } else {
                return
            }
        }
        
        backgroundTask.earliestBeginDate = Date().addingTimeInterval(60 * 60)
        backgroundTask.countOfBytesClientExpectsToSend = 200
        backgroundTask.countOfBytesClientExpectsToReceive = 500 * 1024
        backgroundTask.resume()
    }
    
    func checkIfResponseIsCorrect(response: URLResponse?, error: Error?) -> Bool {
        guard error != nil, let isHttpValid = response?.isHttpResponseValid() else {
            return false
        }
        return isHttpValid
    }
    
    func isGuard(value: Any?) -> Any {
        guard let _ = value else {
            return false
        }
        return true
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let backgroundCompletionHandler = appDelegate.backgroundCompletionHandler else {
                    return
            }
            backgroundCompletionHandler()
        }
    }

}

extension URLResponse {
    func isHttpResponseValid() -> Bool {
        guard let httpResponse = self as? HTTPURLResponse ,(200...299).contains(httpResponse.statusCode) else {
                return false
        }
        return true
    }
}

extension String {
    func urlFromString() -> URL? {
        return URL(string: self)
    }
}

