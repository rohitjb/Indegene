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

class IndengeDataFetcher:  DataFetcher {
    
    static let sharedInstance = IndengeDataFetcher()

    func loadData(urlString: String, completionHandler: @escaping (Data?) -> Void) {
        DownloadManager.shared.startDownload(with: urlString)
    }
}
