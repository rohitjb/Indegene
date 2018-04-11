import UIKit

class ContentView: UIView {
    private let layout = UICollectionViewFlowLayout()
    private let collectionView: UICollectionView
    private let selectionView = UIView()
    private let adapter = ContentAdapter()

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
        collectionView.backgroundColor = UIColor.red
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.isPagingEnabled = true
        
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        applyConstraints()
    }
    
    private func applyConstraints() {
        collectionView.pinToSuperviewEdges()
    }
}
