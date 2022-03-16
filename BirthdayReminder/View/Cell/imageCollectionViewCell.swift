
import UIKit

final class imageCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    // MARK: Public
    private let personImage = UIImageView()
    // MARK: Private
    private let cellView = UIView()
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubviews()
        setupConstrains()
        setupUI()
    }

    // MARK: - Setups
    private func addSubviews() {
        contentView.addSubview(cellView)
        cellView.addSubview(personImage)
    }

    func imageSet(indexPath: IndexPath.Index) {
        personImage.image = UIImage(named: "\(indexPath)")
    }

    private func setupConstrains() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true

        personImage.translatesAutoresizingMaskIntoConstraints = false
        personImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 0).isActive = true
        personImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 0).isActive = true
        personImage.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 0).isActive = true
        personImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 0).isActive = true
    }

    private func setupUI() {
        cellView.backgroundColor = AppColor.viewBackgroundColor
        cellView.layer.cornerRadius = 10
        cellView.layer.masksToBounds = true
    }
    // MARK: - Helpers
}
