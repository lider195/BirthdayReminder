import CoreData
import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties

    // MARK: Public

    // MARK: Private
    private let tableView = UITableView()
    private var personModel = [Person]() {
        didSet {
            tableView.reloadData()
        }
    }

    private let reuseIdentifier = "TableViewCell"
    private var searchArray: [Person] = []
    private var searchController = UISearchController()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstrains()
        setupTableView()
        setupNavigationBar()
        setupAddButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let persons = CoreDataManager.instance.getPerson() else { return }
        personModel = persons
    }

    // MARK: - API

    // MARK: - Setups
    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func setupConstrains() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

    private func setupTableView() {
        tableView.backgroundColor = AppColor.viewBackgroundColor
        view.backgroundColor = AppColor.viewBackgroundColor
        navigationController?.navigationBar.backgroundColor = AppColor.viewBackgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search name"
        navigationItem.searchController = searchController
        searchController.searchBar.searchTextField.layer.masksToBounds = true
        searchController.searchBar.searchTextField.layer.cornerRadius = 5
        searchController.searchBar.barTintColor = UIColor(red: 20 / 255, green: 18 / 255, blue: 29 / 255, alpha: 1.0)
        searchController.searchBar.backgroundColor = .clear
    }

    private func setupNavigationBar() {
        title = "BirthDay Reminder"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(informationViewController))
        addButton.tintColor = .blue
        navigationItem.setRightBarButton(addButton, animated: true)
        let delButton = UIBarButtonItem(barButtonSystemItem: .trash,
                                        target: self,
                                        action: #selector(deleteAllPerson))
        delButton.tintColor = .red

        navigationItem.setLeftBarButton(delButton, animated: true)
    }

    // MARK: - Helpers

    @objc func informationViewController() {
        let informationViewCOntroller = InformationViewController()
        navigationController?.pushViewController(informationViewCOntroller, animated: true)
    }

    @objc func deleteAllPerson() {
        let alert = UIAlertController(title: "Deleted", message: "Delete all information", preferredStyle: .alert)
        let no = UIAlertAction(title: "No", style: .default)
        alert.addAction(no)
        let ok = UIAlertAction(title: "Yes", style: .destructive) { _ in
            CoreDataManager.instance.deleteAllPerson(self.personModel)
            self.personModel.removeAll()
            self.tableView.reloadData()
        }
        alert.addAction(ok)

        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }

    func filterContent(for SearchText: String) {
        searchArray = personModel.filter { array -> Bool in
            if let name = array.name?.lowercased() {
                return name.hasPrefix(SearchText.lowercased())
            }
            return false
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchArray.count
        } else {
            return personModel.count
        }
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            CoreDataManager.instance.deleteEntity(usersArray: personModel, indexPath: indexPath)
            personModel.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                    for: indexPath) as? TableViewCell
        {

            cell.set(personModel[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
