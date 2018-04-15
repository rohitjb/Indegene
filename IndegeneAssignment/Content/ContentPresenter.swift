import Foundation

protocol ContentDisplayer {
    func update(with viewState: ContentViewState)
    func update(with errorViewState: ErrorViewState)
    func attachListener(listener: ContentActionListener)
    func detachListener()
}

struct ContentActionListener {
    let toDetailAction: (ContentType) -> Void
    init(toDetailAction: @escaping (ContentType) -> Void) {
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
        displayer.attachListener(listener: ContentActionListener(toDetailAction: {[weak self] contentType in
            switch contentType {
            case .image(let url):
                print(url)
                self?.contentNavigator.toImageDetail(url: url)
            case .pdf(let url):
                self?.contentNavigator.toPDFDetail(url: url)
            case .video(let url):
                self?.contentNavigator.toVideoDetail(url: url)
            }
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
