import Foundation

class URLSessionFactory {
    let configurationFactory: URLSessionConfigurationFactory
    
    init(configurationFactory: URLSessionConfigurationFactory) {
        self.configurationFactory = configurationFactory
    }
    
    func makeSession(with delegate: URLSessionDelegate? = nil) -> URLSession {
        return URLSession(configuration: configurationFactory.makeSessionConfiguration(),
                          delegate: delegate,
                          delegateQueue: nil)
    }
    
    deinit {
        print("ssdsfdf")
    }
}

class URLSessionConfigurationFactory {
   func makeSessionConfiguration() -> URLSessionConfiguration {
    let sessionNumber = Int(arc4random_uniform(UInt32(50)))
        let configuration = URLSessionConfiguration.background(withIdentifier: "MySession\(sessionNumber)")
//    let configuration = URLSessionConfiguration.default
        configuration.isDiscretionary = true
        configuration.sessionSendsLaunchEvents = true
        configuration.timeoutIntervalForRequest = 30.0;
        configuration.timeoutIntervalForResource = 60.0;
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return configuration
    }

    deinit {
        print("makeSessionConfiguration")
    }
}
