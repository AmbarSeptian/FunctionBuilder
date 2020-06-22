//
//  MenuViewController.swift
//  FunctionalBuilders
//
//  Created by Ambar Septian on 21/06/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import AsyncDisplayKit

class MenuViewController: ASViewController<ASTableNode> {
    init() {
        super.init(node: ASTableNode())
        node.dataSource = self
        node.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuViewController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cell = ASTextCellNode()
        let text: String
        if indexPath.row == 0 {
            text = "AttributedString"
        } else {
            text = "Texture"
        }
        cell.text = text
        return cell
    }
}

extension MenuViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let vc: UIViewController
        if indexPath.row == 0 {
            vc = ViewController()
        } else {
            vc = TextureBuilderViewController()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
