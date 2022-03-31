import UIKit

final class InformationViewController: UIViewController {
    // MARK: - Properties
    // MARK: Public

    // MARK: Private
    private let nameTextField = MainTextField()
    private let surNameTextField = MainTextField()
    private let datePicker = UIDatePicker()
    private let addImageButton = UIButton()
    private let addImageView = UIImageView()
    private let imageViewCollectionView = UIView()
    private let cancelButton = UIButton()
    private var textFields = UITextField()
    private let layout = UICollectionViewFlowLayout()
    private let reuseIdentifier = "imageCollectionViewCell"
    private var topConstrains = NSLayoutConstraint()
    private var hours: Int = -1
    private var minutes: Int = -1
    // MARK: Lazy
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstrains()
        setupUI()
        barButton()
        setupButton()
        settingTextField()
        setupCollectionView()
    }

    // MARK: - API

    // MARK: - Setups
    private func addSubviews() {
        view.addSubview(nameTextField)
        view.addSubview(surNameTextField)
        view.addSubview(datePicker)
        view.addSubview(addImageButton)
        view.addSubview(addImageView)
        view.addSubview(imageViewCollectionView)
        view.addSubview(textFields)
        imageViewCollectionView.addSubview(cancelButton)
        imageViewCollectionView.addSubview(collectionView)
    }

    private func setupConstrains() {
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        addImageButton.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -10).isActive = true
        addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        addImageButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addImageButton.widthAnchor.constraint(equalToConstant: 60).isActive = true

        addImageView.translatesAutoresizingMaskIntoConstraints = false
        addImageView.topAnchor.constraint(equalTo: addImageButton.topAnchor, constant: 0).isActive = true
        addImageView.bottomAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 0).isActive = true
        addImageView.leadingAnchor.constraint(equalTo: addImageButton.leadingAnchor, constant: 0).isActive = true
        addImageView.trailingAnchor.constraint(equalTo: addImageButton.trailingAnchor, constant: 0).isActive = true

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 220).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 320).isActive = true

        surNameTextField.translatesAutoresizingMaskIntoConstraints = false
        surNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30).isActive = true
        surNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        surNameTextField.widthAnchor.constraint(equalToConstant: 320).isActive = true

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: surNameTextField.bottomAnchor, constant: 30).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true

        imageViewCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imageViewCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        imageViewCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imageViewCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        topConstrains = imageViewCollectionView.heightAnchor.constraint(equalToConstant: 0)
        topConstrains.isActive = true

        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: imageViewCollectionView.topAnchor, constant: 10).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: imageViewCollectionView.centerXAnchor, constant: 0).isActive = true

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: imageViewCollectionView.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: imageViewCollectionView.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: imageViewCollectionView.trailingAnchor, constant: 0).isActive = true
    }

    private func setupUI() {
        imageViewCollectionView.backgroundColor = AppColor.viewBackgroundColor
        collectionView.backgroundColor = AppColor.viewBackgroundColor
        view.backgroundColor = AppColor.viewBackgroundColor
        navigationController?.navigationBar.backgroundColor = AppColor.viewBackgroundColor
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        addImageView.image = UIImage(systemName: "plus.circle")
        addImageView.layer.cornerRadius = 30
        addImageView.layer.masksToBounds = true
        addImageButton.backgroundColor = .clear
        addImageButton.tintColor = .clear
        addImageButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil),
                                forCellWithReuseIdentifier: reuseIdentifier)
    }

    private func setupButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelView), for: .touchUpInside)
    }

    private func settingTextField() {
        nameTextField.setLabel("Name")
        surNameTextField.setLabel("SurName")
        textFields.setInputDatePicker(target: self, selector: #selector(saveTimeNotification))
    }

    private func barButton() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save,
                                         target: self,
                                         action: #selector(savePersonInformation))
        let time = UIBarButtonItem(title: "Time Notification",
                                   style: .done,
                                   target: self,
                                   action: #selector(timeNotification))
        saveButton.tintColor = .blue
        navigationItem.setRightBarButtonItems([saveButton, time], animated: true)
    }

    // MARK: - Helpers
    @objc func saveTimeNotification() {
        if let datePickers = textFields.inputView as? UIDatePicker {

            let userNotification = datePickers.date
            let hour = DateFormatter()
            let minute = DateFormatter()

            hour.dateFormat = "HH"
            minute.dateFormat = "mm"
            hours = Int(hour.string(from: userNotification))!
            minutes = Int(minute.string(from: userNotification))!
        }
        textFields.endEditing(true)
    }

    @objc func addImage() {
        topConstrains.constant = 250
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        }
    }
    @objc func timeNotification() {
        textFields.becomeFirstResponder()
    }
    @objc func cancelView() {
        topConstrains.constant -= 250
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func savePersonInformation() -> UIAlertController {
        let name = nameTextField.text
        let surName = surNameTextField.text

        let userDate = datePicker.date

        let brDay = Calendar.current.dateComponents([.year, .month, .day], from: datePicker.date)

        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date())

        let age = Int16(today.year! - brDay.year!)

        let alert = UIAlertController(title: "Ошибка",
                                      message: "Заполни все поля и \n выбери время уведомления",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))

        if name.isEmpty || surName.isEmpty || hours == -1 || minutes == -1 {
            present(alert, animated: true,
                    completion: nil)

            return alert
        } else {
            let person = Person(name: name,
                                surName: surName,
                                date: userDate,
                                age: age,
                                imagePerson: (addImageView.image?.pngData())!)
            CoreDataManager.instance.savePerson(person)

            NotificationManagers.notification(name: name, date: userDate, hour: hours, minut: minutes)

            navigationController?.popViewController(animated: true)
            return alert
        }
    }
}

extension InformationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as? imageCollectionViewCell
        {
            cell.imageSet(indexPath: indexPath.row + 1)

            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addImageView.image = UIImage(named: String(indexPath.row + 1))
    }
}
