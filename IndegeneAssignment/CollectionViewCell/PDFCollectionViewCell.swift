import UIKit
import ROThumbnailGenerator
import PDFKit

class PDFCollectionViewCell: UICollectionViewCell {
    let thumbnailImageView = UIImageView()
    let downloadManager = DownloadManager.shared
    private var isDownloading: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(thumbnailImageView)
        thumbnailImageView.pinToSuperviewEdges()
    }
    
    func updateView(with url: String) {
        downloadManager.loadData(with: url) { (path) in
            guard let filePath = path else {
                return
            }
            let thumbnailImage = self.pdfThumbnail(url: filePath)
            self.thumbnailImageView.image = thumbnailImage
        }
    }
    
    func pdfThumbnail(url: URL) -> UIImage? {
        guard let data = try? Data(contentsOf: url),
            let page = PDFDocument(data: data)?.page(at: 0) else {
                return nil
        }
        
        let width: CGFloat = bounds.width
        let pageSize = page.bounds(for: .mediaBox)
        let pdfScale = width / pageSize.width
        
        // Apply if you're displaying the thumbnail on screen
        let scale = UIScreen.main.scale * pdfScale
        let screenSize = CGSize(width: pageSize.width * scale, height: pageSize.height * scale)
        
        return page.thumbnail(of: screenSize, for: .mediaBox)
    }

}
