//
//  TaskCell.swift
//  TechnicalExam
//
//  Created by Eliric on 11/19/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnCheckMark: UIButton!
    let uncheckedImage = "CheckBoxUnChecked"
    let checkedImage = "CheckBoxChecked"

    func setCell(task:Task){
        lblDescription.text = task.description
        if let isCompleted = task.status{
            if(isCompleted){
                if let image = UIImage(named: checkedImage) {
                    btnCheckMark.setImage(image, for: .normal)
                }
            }else{
                if let image = UIImage(named: uncheckedImage) {
                    btnCheckMark.setImage(image, for: .normal)
                }
            }
        }
    }
}
