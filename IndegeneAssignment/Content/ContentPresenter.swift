import Foundation

protocol ContentDisplayer {
    func attachListener(listener: ContentActionListener)
    func detachListener()
}

struct ContentActionListener {
    let toDetailAction: (String) -> Void
    init(toDetailAction: @escaping (String) -> Void) {
        self.toDetailAction = toDetailAction
    }
}

class ContentPresenter {
    private let useCase: ContentUseCase
    private let displayer: ContentDisplayer
    private let contentNavigator: ContentNavigator
    
    init(useCase: ContentUseCase,
         displayer: ContentDisplayer,
         contentNavigator: ContentNavigator) {
        self.useCase = useCase
        self.contentNavigator = contentNavigator
        self.displayer = displayer
    }
    
    func startPresenting() {
        displayer.attachListener(listener: ContentActionListener(toDetailAction: { url in
            print(url)
        }))
    }
    
    func stopPresenting() {
        displayer.detachListener()
    }
}
