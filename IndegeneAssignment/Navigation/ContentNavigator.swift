import Foundation
import  UIKit

protocol ContentNavigator {
    func toImageDetail(url: String)
    func toPDFDetail(url: String)
    func toVideoDetail(url: String)
}

class IndengeContentNavigator: ContentNavigator {
    lazy var navController: UINavigationController = {
        let contentViewController = ContentViewController(navigator: self)
        let navController = UINavigationController(rootViewController: contentViewController)
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = UIColor.orange
        return navController
    }()
    
    func toImageDetail(url: String) {
        let imageViewController = ImageViewController(url: url)
        navController.present(imageViewController, animated: true, completion: nil)
    }
    
    func toPDFDetail(url: String) {
        let pdfViewController = PDFDetailViewController(url: url)
        navController.present(pdfViewController, animated: true, completion: nil)
    }
    
    func toVideoDetail(url: String) {
        let videoViewController = VideoDetailViewController(url: url)
        navController.present(videoViewController, animated: true, completion: nil)
    }

}
