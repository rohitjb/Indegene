import Foundation
import UIKit

class MainNavigator: NSObject {
    
    private var navigationController: UINavigationController
    private var window: UIWindow?
    private let contentNavigator = IndengeContentNavigator()
    
    override init() {
        self.navigationController = contentNavigator.navController
        super.init()
    }
    
    func toStart(inWindow mainWindow: UIWindow) {
        window = mainWindow
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

