import UIKit

final class TableViewCell: UITableViewCell {
    // MARK: - Properties
    // MARK: Public

    // MARK: Private
    private let view = UIView()
    private let nameLabel = UILabel()
    private let surNameLabel = UILabel()
    private var dateLabel = UILabel()
    private var agelabel = UILabel()
    private var imagePerson = UIImageView()
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstrains()
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - API
  
    
    func set(_ user: Person) {
        nameLabel.text = user.name
        surNameLabel.text = user.surName

        dateLabel.text = dateFormatter(user.date)
        imagePerson.image = UIImage(data: user.imagePerson)

        agelabel.text = " Age - \(user.age)"
    }

    // MARK: - Setups
    private func addSubviews() {
        contentView.addSubview(view)
        contentView.addSubview(nameLabel)
        contentView.addSubview(surNameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(agelabel)
        contentView.addSubview(imagePerson)
    }

    private func setupConstrains() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18).isActive = true
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true

        surNameLabel.translatesAutoresizingMaskIntoConstraints = false
        surNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
        surNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        surNameLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true

        agelabel.translatesAutoresizingMaskIntoConstraints = false
        agelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        agelabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        agelabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        agelabel.widthAnchor.constraint(equalToConstant: 100).isActive = true

        imagePerson.translatesAutoresizingMaskIntoConstraints = false
        imagePerson.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imagePerson.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        imagePerson.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imagePerson.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }

    private func setupUI() {
        contentView.backgroundColor = AppColor.viewBackgroundColor
        nameLabel.textAlignment = .center
        surNameLabel.textAlignment = .center
        imagePerson.layer.cornerRadius = 45
        imagePerson.layer.masksToBounds = true
        view.backgroundColor = AppColor.cellcolor
        view.layer.cornerRadius = 25
        agelabel.textAlignment = .center
    }
    private func dateFormatter(_ date: Date) -> String{
         let dateAnswer = DateFormatter()
         dateAnswer.dateFormat = "dd-MM-YYYY"
         let releasingDate: String = dateAnswer.string(from: date)
         return releasingDate
     }
    // MARK: - Helpers
}
