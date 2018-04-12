import Foundation
import UIKit

class AsyncImageView: UIImageView {
    var dataFetcher: DataFetcher
    
    override init(frame: CGRect) {
        let urlSessionFactory = URLSessionFactory(configurationFactory: URLSessionConfigurationFactory())
        self.dataFetcher = IndengeDataFetcher(urlSessionFactory: urlSessionFactory)
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
//        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
    
    func reset() {
        self.image = nil
    }
    
    func loadImage(urlString: String){
        dataFetcher.loadData(urlString: urlString) { (data) in
            guard let data = data else {
                return
            }
            self.image = UIImage(data: data)
        }
    }
}

