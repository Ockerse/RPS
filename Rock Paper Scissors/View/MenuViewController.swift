//
//  MenuViewController.swift
//  Rock Paper Scissors
//
//  Created by Carson Uecker-Herman on 11/20/19.
//  Copyright © 2019 armin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GameCenterHelper.helper.viewController = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onlinegameBtn(_ sender: Any) {
        
        GameCenterHelper.helper.presentMatchmaker()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
