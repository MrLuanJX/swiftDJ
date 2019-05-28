//
//  LJX_MineViewController.swift
//  JJDS
//
//  Created by a on 2019/5/10.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit

class LJX_MineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.green
        
        let colors = [UIColor.hexadecimalColor(hexadecimal: "#191970").cgColor,
                      UIColor.hexadecimalColor(hexadecimal: "#4682B4").cgColor,
        ]
        LJX_LayerRadius.gradientColor(view: view,colors)
        // Do any additional setup after loading the view.
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
