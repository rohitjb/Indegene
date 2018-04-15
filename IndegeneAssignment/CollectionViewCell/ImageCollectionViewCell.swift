import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    private let asyncImageView = AsyncImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        addSubview(asyncImageView)
        applyConstraints()
    }
    
    private func applyConstraints() {
        asyncImageView.pinToSuperviewEdges()
    }
    
    func updateView(with url: String) {
        asyncImageView.loadImage(urlString: url)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
