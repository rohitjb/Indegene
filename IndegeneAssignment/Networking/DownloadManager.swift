import Foundation
import UIKit

class DownloadManager: NSObject, URLSessionDelegate, URLSessionDownloadDelegate {
    
//    static var shared = DownloadManager()
    var pathCompletionHandler: ((URL?) -> Void)? = nil
    let localFileManager: LocalFileManager

    init(localFileManager: LocalFileManager = IndengeLocalFileManager()) {
        self.localFileManager = localFileManager
    }
    
    func makeSessionConfiguration() -> URLSessionConfiguration {
        let sessionNumber = Int(UInt32(50).randomNumber())
        let configuration = URLSessionConfiguration.background(withIdentifier: "MySession\(sessionNumber)")
        configuration.isDiscretionary = true
        configuration.sessionSendsLaunchEvents = true
        configuration.timeoutIntervalForRequest = 30.0;
        configuration.timeoutIntervalForResource = 60.0;
        return configuration
    }

    var session : URLSession {
        get {
            let config = makeSessionConfiguration()
            // Warning: If an URLSession still exists from a previous download, it doesn't create
            // a new URLSession object but returns the existing one with the old delegate object attached!
            config.requestCachePolicy = .returnCacheDataElseLoad
            return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        guard let url = downloadTask.originalRequest?.url else { return }
        
        if let savedPath = localFileManager.updateFileAndSaveIfDoesNotExist(at: location, url: url) {
            pathCompletionHandler?(savedPath)
            return
        }
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let backgroundCompletionHandler =
                appDelegate.backgroundCompletionHandler else {
                    return
            }
            backgroundCompletionHandler()
        }
    }

    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    }
    
    func loadData(with path: String, completionHandler: @escaping (URL?) -> Void) {
        guard let url = URL(string: path) else {
            return
        }
        if let savedPath = localFileManager.savedPath(for: url) {
            completionHandler(savedPath)
            return
        }
        pathCompletionHandler = completionHandler
        let task = session.downloadTask(with: url)
        task.resume()
    }
}
