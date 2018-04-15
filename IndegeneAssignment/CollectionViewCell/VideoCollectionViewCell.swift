import UIKit
import AVFoundation

class VideoCollectionViewCell: UICollectionViewCell {
    let videoImageView = UIImageView()
    let downloadManager = DownloadManager()
    let playButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.black
        addSubview(videoImageView)
        addSubview(playButton)
        
        let image = UIImage(named: "play")
        playButton.setImage(image, for: .normal)

        videoImageView.pinToSuperviewEdges()
        
        playButton.pinCenterX(to: self)
        playButton.pinCenterY(to: self)
        
        playButton.addWidthConstraint(constant: 40)
        playButton.addHeightConstraint(constant: 40)

    }
    
    func updateView(with url: String) {
        downloadManager.loadData(with: url) { (path) in
            guard let filePath = path else {
                return
            }
            DispatchQueue.main.async {
                self.videoImageView.image = self.getThumbnailImage(for: filePath)
            }
        }
    }

    func getThumbnailImage(for url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(1, 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        return nil
    }

}
