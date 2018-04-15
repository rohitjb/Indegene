import Foundation
import UIKit

enum DataError: Error {
    case notCorrectResponse
    case dataUnavailable
    case notValidUrl
}

protocol DataFetcher {
    func loadData(urlString: String, completionHandler: @escaping (URL?) -> Void)
}

class IndengeDataFetcher:  DataFetcher {
    
    func loadData(urlString: String, completionHandler: @escaping (URL?) -> Void) {
        DownloadManager.shared.loadData(with: urlString, completionHandler: completionHandler)
    }
}
