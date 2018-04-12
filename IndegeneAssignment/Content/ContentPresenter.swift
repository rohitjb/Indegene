import Foundation

protocol ContentDisplayer {
    func update(with viewState: ContentViewState)
    func update(with errorViewState: ErrorViewState)
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
        update(with: useCase.contentDataState())
        displayer.attachListener(listener: ContentActionListener(toDetailAction: { path in
            print(path)
        }))
    }
    
    func update(with dataState: DataState) {
        switch dataState {
        case .idleState(let viewState):
            displayer.update(with: viewState)
        case .errorState(let errorViewState):
            displayer.update(with: errorViewState)
        }
    }
    
    func stopPresenting() {
        displayer.detachListener()
    }
}
