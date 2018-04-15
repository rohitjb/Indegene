import UIKit

class ContentView: UIView, ContentDisplayer {
    private let layout = UICollectionViewFlowLayout()
    private let collectionView: UICollectionView
    private let selectionView = UIView()
    private let adapter = ContentAdapter()
    private var actionListener: ContentActionListener?

    override init(frame: CGRect) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This view is not designed to be used with xib or storyboard files")
    }
    
    private func setup() {
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.black
        
        adapter.registerCells(with: collectionView)
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0

        applyConstraints()
    }
    
    private func applyConstraints() {
        collectionView.pinToSuperviewEdges()
    }
    
    func update(with mode: Mode) {
        adapter.update(with: mode)
        collectionView.performBatchUpdates({
            self.collectionView.reloadData()
        }, completion: nil)
    }
    
    func update(with viewState: ContentViewState) {
        adapter.update(with: viewState)
        collectionView.reloadData()
    }
    
    func update(with errorViewState: ErrorViewState) {
        print(errorViewState)
    }

    func attachListener(listener: ContentActionListener) {
        actionListener = listener
        adapter.attachListener(listener: listener)
    }
    
    func detachListener() {
        adapter.detachListener()
    }
}
