import Foundation
import UIKit

class AsyncImageView: UIImageView {
    private let downloadManager = DownloadManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
    
    func reset() {
        self.image = nil
    }
    
    func loadImage(urlString: String){
        downloadManager.loadData(with: urlString) { (url) in
            guard let filePath = url, let data = try? Data(contentsOf: filePath) else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
            }
        }
    }
}

