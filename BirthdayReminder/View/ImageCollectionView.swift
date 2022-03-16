import UIKit

final class ImageCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell",
                                                         for: indexPath) as? imageCollectionViewCell
        {
            cell.imageSet(indexPath: indexPath.row + 1)
            cell.backgroundColor = .red
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


    }
}
