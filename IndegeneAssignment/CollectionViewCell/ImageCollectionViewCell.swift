import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    private let asyncImageView = AsyncImageView(frame: .zero)
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor.black
        addSubview(asyncImageView)
        addSubview(activityIndicatorView)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()

        applyConstraints()
    }
    
    private func applyConstraints() {
        asyncImageView.pinToSuperviewEdges()
        activityIndicatorView.pinCenterX(to: self)
        activityIndicatorView.pinCenterY(to: self)
        
        activityIndicatorView.addWidthConstraint(constant: 25)
        activityIndicatorView.addHeightConstraint(constant: 25)

    }
    
    func updateView(with url: String) {
        asyncImageView.loadImage(urlString: url) { [weak self] in
            self?.activityIndicatorView.stopAnimating()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
