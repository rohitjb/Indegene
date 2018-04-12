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
}

class URLSessionConfigurationFactory {
   func makeSessionConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.background(withIdentifier: "MySession")
        configuration.isDiscretionary = true
        configuration.sessionSendsLaunchEvents = true
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return configuration
    }

}
