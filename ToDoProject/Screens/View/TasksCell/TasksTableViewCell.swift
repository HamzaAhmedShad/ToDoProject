//
//  TasksTableViewCell.swift
//  ToDoProject
//
//  Created by BS1101 on 21/6/23.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    var task: Task?
    @IBOutlet weak var checkBtn: UIButton!
    
    @IBOutlet weak var taskText: UILabel!
    
    
    
    func taskConfig(with task: Task) {
        taskText.text = task.title
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func checkBtnPressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        // Update button image based on the selected state
        let imageName = sender.isSelected ? "checkmark.circle" : "circle"
        let image = UIImage(systemName: imageName)
        checkBtn.setImage(image, for: .normal)
    }
}
