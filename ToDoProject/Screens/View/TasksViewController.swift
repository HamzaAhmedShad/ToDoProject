//
//  TasksViewController.swift
//  ToDoProject
//
//  Created by BS1101 on 21/6/23.
//

import UIKit

class TasksViewController: UIViewController {
    
    
    @IBOutlet weak var GotoProfileBtn: UIButton!
    
    
    @IBOutlet weak var TasksTableView: UITableView!
    
    @IBOutlet weak var AddNewTaskBtn: UIButton!
    
    private let tasksViewModel = TasksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        TasksTableView.register(UINib(nibName: "TasksTableViewCell", bundle: .main), forCellReuseIdentifier: "TasksTableViewCell")
        TasksTableView.rowHeight = 80
        TasksTableView.dataSource = self
        TasksTableView.delegate = self
        fetchTasks()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTasks), name: NSNotification.Name("TaskAddedNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTasks), name: NSNotification.Name("TaskDeletedNotification"), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("TaskAddedNotification"), object: nil)
    }
    func fetchTasks(){
        tasksViewModel.fetchTasks { [weak self] result in
            switch result {
            case .success:
                self?.TasksTableView.reloadData()
            case .failure(let error):
                print("Error fetching tasks: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func AddNewTaskBtnPressed(_ sender: UIButton) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "AddNewTaskViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToProfilePressed(_ sender: UIButton) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "LogoutViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension TasksViewController: UITableViewDelegate, UITableViewDataSource{
    //    TasksTableView.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksViewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksTableViewCell", for: indexPath) as! TasksTableViewCell
        print("tableView(_:cellForRowAt:) called")
        let task = tasksViewModel.tasks[indexPath.row]
        cell.taskConfig(with: task)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TasksTableView.deselectRow(at: indexPath, animated: false)
        let task = tasksViewModel.tasks[indexPath.row]
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TasksDetailsViewController") as? TasksDetailsViewController {
                vc.tasks = task
                self.navigationController?.pushViewController(vc, animated: true)
            }
    }
    @objc func reloadTasks() {
        tasksViewModel.fetchTasks { [weak self] result in
            switch result {
            case .success:
                self?.TasksTableView.reloadData()
            case .failure(let error):
                print("Error fetching tasks: \(error.localizedDescription)")
            }
        }
    }
}
