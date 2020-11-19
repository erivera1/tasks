//
//  ViewController.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         *   Tasks
         *   1. Add a UIImageView and UILabel below it using autolayout
         *   2. Change the text to your favorite quote
         *   3. Set it to any image that best illustrate the quote provided
         *   4. Display this screen for 3 seconds and then using storyboard either with UINavigationController or any navigate to TaskViewController
         *
        **/
        
        let _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
                // do stuff 3 seconds later
            self.performSegue(withIdentifier: "showMain", sender: self)
        }
    }


}

