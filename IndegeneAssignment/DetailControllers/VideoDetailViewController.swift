import UIKit
import AVKit
import AVFoundation

class VideoDetailViewController: UIViewController {
    
    let closeButton = UIButton()
    let videoURL: String
    private var playerView = AVPlayerViewController()

    init(url: String) {
        videoURL = url
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
        
        view.addSubview(playerView.view)
        addVideoPlayer()
        
        applyConstraints()
        
        
    }
    
    private func addVideoPlayer() {
        if playerView.player?.status != .readyToPlay {
            guard let url = URL(string: videoURL) else {
                return
            }
            let player = AVPlayer(url: url)
            playerView.player = player
            playerView.view.frame = CGRect(x: 0, y: 70, width: view.bounds.width, height: view.bounds.height)
            playerView.player?.play()
        }
    }
    
    private func applyConstraints() {
        closeButton.pinToSuperviewTop(constant: 20)
        closeButton.pinToSuperviewLeading(constant: 8)
        closeButton.addWidthConstraint(constant: 40)
        closeButton.addHeightConstraint(constant: 40)        
    }
    
    @objc private func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }

}
