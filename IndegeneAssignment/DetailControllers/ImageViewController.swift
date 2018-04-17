import UIKit

class ImageViewController: UIViewController {

    let closeButton = UIButton()
    private let asyncImageView = AsyncImageView(frame: .zero)
    let imageURL: String
    
    init(url: String) {
        imageURL = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = UIColor.black
        let image = UIImage(named: "close")
        closeButton.setImage(image, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        view.addSubview(closeButton)
        asyncImageView.contentMode = .scaleAspectFit
        view.addSubview(asyncImageView)
        applyConstraints()
        asyncImageView.loadImage(urlString: imageURL)
    }
    
    private func applyConstraints() {
        closeButton.pinToSuperviewTop(constant: 20)
        closeButton.pinToSuperviewLeading(constant: 8)
        closeButton.addWidthConstraint(constant: 40)
        closeButton.addHeightConstraint(constant: 40)
        
        asyncImageView.pinToSuperview(edges: [.leading, .trailing, .bottom])
        asyncImageView.pinToSuperviewTop(constant: 70)
    }

    @objc private func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
