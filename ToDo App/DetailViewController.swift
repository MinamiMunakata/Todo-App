//
//  DetailViewController.swift
//  ToDo App
//
//  Created by minami on 2018-10-09.
//  Copyright © 2018 宗像三奈美. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let todo = todoItem {
            if let label = detailDescriptionLabel {
                label.text = todo.todoDescription
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var todoItem: Todo? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

