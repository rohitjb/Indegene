import Foundation

class DownloadManager: NSObject, URLSessionDelegate, URLSessionDownloadDelegate {
    
    static var shared = DownloadManager()

    func makeSessionConfiguration() -> URLSessionConfiguration {
        let sessionNumber = Int(arc4random_uniform(UInt32(50)))
        let configuration = URLSessionConfiguration.background(withIdentifier: "MySession\(sessionNumber)")
        configuration.isDiscretionary = true
        configuration.sessionSendsLaunchEvents = true
        configuration.timeoutIntervalForRequest = 30.0;
        configuration.timeoutIntervalForResource = 60.0;
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return configuration
    }

    var session : URLSession {
        get {
            let config = makeSessionConfiguration()
            // Warning: If an URLSession still exists from a previous download, it doesn't create
            // a new URLSession object but returns the existing one with the old delegate object attached!
            return URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        debugPrint("Download finished: \(location)")
        try? FileManager.default.removeItem(at: location)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        debugPrint("Task completed: \(task), error: \(String(describing: error))")
    }
    
    func startDownload(with path: String) {
        guard let url = URL(string: path) else {
            return
        }
        
        let task = session.downloadTask(with: url)
        task.resume()
    }
}
