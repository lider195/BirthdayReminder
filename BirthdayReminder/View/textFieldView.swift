import UIKit
final class MainTextField: UIView, UITextFieldDelegate {
    // MARK: - Properties
    // MARK: Public
    var text: String {
        textField.text ?? ""
    }

    // MARK: Private
    private let textField = UITextField()
    private let label = UILabel()
    private let separatorView = UIView()
    private var wightConst = NSLayoutConstraint()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstrains()
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - API
    func setLabel(_ title: String) {
        label.text = title
        textField.placeholder = title
    }

    // MARK: - Setups
    private func addSubviews() {
        addSubview(textField)
        addSubview(label)
        addSubview(separatorView)
    }

    private func setupConstrains() {
        label.translatesAutoresizingMaskIntoConstraints = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3).isActive = true
        wightConst = label.widthAnchor.constraint(equalToConstant: 0)
        wightConst.isActive = true

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        textField.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -2).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3).isActive = true
    }

    private func setupUI() {
        label.font = .systemFont(ofSize: 15)
        label.text = "Title"
        label.textColor = AppColor.titleLabelColor
        separatorView.backgroundColor = .red
        textField.delegate = self
        textField.addTarget(self, action: #selector(startSettTextField), for: .editingDidBegin)

        textField.addTarget(self, action: #selector(endSettTextField), for: .editingDidEnd)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: - Helpers
    @objc func endSettTextField() {
        let entryName = textField.text!
        if !entryName.isEmpty {
            separatorView.backgroundColor = .systemGreen
        }
    }
    @objc func startSettTextField() {
        textField.placeholder = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        wightConst.constant += 75

        UIView.animate(withDuration: 1) {
            self.layoutIfNeeded()
        }
    }
}
