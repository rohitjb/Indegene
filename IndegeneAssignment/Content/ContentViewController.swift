import UIKit

enum Mode: String {
    case list = "List"
    case grid = "Grid"
    
    func title() -> String {
        switch self {
        case .grid:
            return "List"
        case .list:
            return "Grid"
        }
    }
}

class ContentViewController: UIViewController {

    private let contentView = ContentView()
    private let presenter: ContentPresenter
    private var mode: Mode = .list {
        didSet {
            contentView.update(with: mode)
        }
    }
    
    init(navigator: ContentNavigator) {
        let cacheDataSource = IndengeContentDataSource(repository: IndgeneContentRepository())
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
        self.title = "Ingene Conetent"
        
        let modeBarButton = UIBarButtonItem(title: mode.title(),
                                            style: .done,
                                            target: self,
                                            action: #selector(changeMode))
        self.navigationItem.rightBarButtonItem = modeBarButton
        
        view.addSubview(contentView)
        contentView.pinToSuperviewEdges()
    }
    
    override func viewDidLoad() {
        presenter.startPresenting()
    }

    @objc private func changeMode() {
        switch mode {
        case .list:
            mode = .grid
        case .grid:
            mode = .list
        }
        self.navigationItem.rightBarButtonItem?.title = mode.title()
    }
    
    deinit {
        presenter.stopPresenting()
    }
}

