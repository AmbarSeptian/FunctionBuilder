//
//  ViewController.swift
//  FunctionalBuilders
//
//  Created by Ambar Septian on 14/06/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let flag = true
        let label = UILabel()
        let text = NSAttributedString {
            "Folder"
            if flag {
                UIImage(named: "folder")!
               NSAttributedString {
                   "Folder "
                    Link(url: "https://google.com", label: "Google")
               }
            }
            
            NSAttributedString {
                "Folder "
                UIImage(named: "folder")!
            }

            " - "

            NSAttributedString {
                "Document "
                UIImage(named: "doc")!
            }
            .withAttributes([
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.red
            ])
        }
        
//        label.attributedText = text
        label.frame = CGRect(x: 20, y: 100, width: view.bounds.width, height: 400)
        view.addSubview(label)
        
        
        let text2 = NSAttributedString {
            Text("asdfsdf")
                .font(.boldSystemFont(ofSize: 14))
            Text("sdfsdfds")
                .color(.blue)
                .font(.systemFont(ofSize: 14))
            Image("folder")
                .renderingMode(.alwaysOriginal)
            Link(url: "https://google.com", label: "Open Google")
        }
        
        label.attributedText = text2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}
