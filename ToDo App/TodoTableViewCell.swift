//
//  TodoTableViewCell.swift
//  ToDo App
//
//  Created by minami on 2018-10-09.
//  Copyright © 2018 宗像三奈美. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    // images
    let checked = UIImage(named: "checked")
    let unchecked = UIImage(named: "unchecked")
    

    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var priorityImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkboxButton.setImage(unchecked, for: .normal)
        checkboxButton.setImage(checked, for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkon(_ sender: UIButton) {
        checkboxButton.isSelected = !checkboxButton.isSelected
    }
    

}
