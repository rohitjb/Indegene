import UIKit

class ContentViewController: UIViewController {

    private let contentView = ContentView()
    private let presenter: ContentPresenter
    
    init(navigator: ContentNavigator) {
        let cacheDataSource = IndengeContentDataSource(fetcher: IndgeneContentFetcher())
        let useCase = IndengeContentUseCase(dataSource: cacheDataSource)
        self.presenter = ContentPresenter(useCase: useCase,
                                          displayer: contentView,
                                          contentNavigator: navigator)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.addSubview(contentView)
        contentView.pinToSuperviewEdges()
    }
    
    override func viewDidLoad() {
        presenter.startPresenting()
    }

    deinit {
        presenter.stopPresenting()
    }
}

