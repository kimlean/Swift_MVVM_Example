import UIKit

class UserViewController: UIViewController, UITableViewDataSource {
    private var viewModel = UserViewModel()
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the tableView
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        // Bind to the ViewModel
        viewModel.onUsersUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // Fetch users from the API
        viewModel.loadUsers()
        
        // UI setup
        setupUI()
    }
    
    private func setupUI() {
        title = "Users"
        view.backgroundColor = .white
    }
    
    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = viewModel.users[indexPath.row]
        cell.textLabel?.text = "\(user.name) - \(user.email)"
        return cell
    }
}
