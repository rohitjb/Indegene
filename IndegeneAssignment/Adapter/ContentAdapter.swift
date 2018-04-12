import UIKit
import Foundation

class ContentAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let spacing: CGFloat = 2
    private var toDetailAction: ((String) -> Void)?
    private var collectionMode: Mode = .list
    private var contents = [Content]()
    
    func attachListener(listener: ContentActionListener) {
        toDetailAction = listener.toDetailAction
    }
    
    func detachListener() {
        toDetailAction = nil
    }
    
    func update(with contentViewState: ContentViewState) {
        contents = contentViewState.content
    }
    
    func update(with mode: Mode) {
        collectionMode = mode
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = UIScreen.main.bounds.width
        if collectionMode == .grid {
            width = collectionView.bounds.width/2 - (spacing * 2)
        }
        let size = sizeForView(width: width)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ContentCollectionViewCell
        
        if indexPath.item  == 0 {
            cell.backgroundColor = UIColor.green
        } else if indexPath.item % 2 == 0 {
            cell.backgroundColor = UIColor.black
        }else if indexPath.item % 3 == 0 {
            cell.backgroundColor = UIColor.blue
        }  else {
            cell.backgroundColor = UIColor.brown
        }
        return cell
    }
    
    func sizeForView(width: CGFloat) -> CGSize {
        let height = (width * 3)/4
        return CGSize(width: width, height: height)
    }
}
