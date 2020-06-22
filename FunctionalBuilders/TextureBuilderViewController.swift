//
//  TextureBuilderViewController.swift
//  FunctionalBuilders
//
//  Created by Ambar Septian on 17/06/20.
//  Copyright © 2020 Ambar Septian. All rights reserved.
//

import AsyncDisplayKit

class TextureBuilderViewController: ASViewController<ASDisplayNode> {
    let nodes: [ASDisplayNode] = {
        return [#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)].enumerated().map { index, color -> ASDisplayNode in
            let node = ASDisplayNode()
            node.backgroundColor = color
            node.style.preferredSize = CGSize(width: 50, height: 50)
            node.accessibilityIdentifier = "color - \(index)"
            return node
        }
    }()
    
    let descriptionNode: ASTextNode = {
        let textNode = ASTextNode()
        textNode.attributedText = NSAttributedString(string: "Footer",
                                                     attributes: [.font : UIFont.boldSystemFont(ofSize: 18)])
        return textNode
    }()
    
    let checkmarkNode: ASImageNode = {
        let imageNode = ASImageNode()
        imageNode.image = UIImage(named: "checkmark-icon")
        imageNode.style.preferredSize = CGSize(width: 50, height: 50)
        return imageNode
    }()
    
    let crossMarkNode: ASImageNode = {
        let imageNode = ASImageNode()
        imageNode.image = UIImage(named: "crossmark-icon")
        imageNode.style.preferredSize = CGSize(width: 50, height: 50)
        return imageNode
    }()
    
    let toggleFooterButton: ASButtonNode = {
        let buttonNode = ASButtonNode()
        buttonNode.setAttributedTitle(NSAttributedString(string: "Toggle Footer",
                                                         attributes: [.font : UIFont.boldSystemFont(ofSize: 18)]), for: .normal)
        return buttonNode
    }()
    
    let toggleCheckmarkButton: ASButtonNode = {
        let buttonNode = ASButtonNode()
        buttonNode.setAttributedTitle(NSAttributedString(string: "Toggle Checkmark",
                                                         attributes: [.font : UIFont.boldSystemFont(ofSize: 18)]), for: .normal)
        return buttonNode
    }()
    
    var isShowFooter = false
    var isShowCheckmark = true
    
    init() {
        let rootNode = ASDisplayNode()
        rootNode.automaticallyManagesSubnodes = true
        rootNode.backgroundColor = .white
        super.init(node: rootNode)
        
        toggleFooterButton.addTarget(self,
                                     action: #selector(self.toggleCheckmark(_:)),
                                     forControlEvents: .touchUpInside)
        
        toggleCheckmarkButton.addTarget(self,
                                        action: #selector(self.toggleCheckmark(_:)),
                                        forControlEvents: .touchUpInside)
         
        
        rootNode.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }
//            return self.nativeTextureLayoutSpec()
            return VLayout {
                self.nodes[0]
                self.nodes[1]

                HLayout {
                    self.nodes[2]
                    self.nodes[3]
                }
                .spacing(20)
                .justifyContent(.center)

                if self.isShowFooter {
                    self.descriptionNode
                }

                if self.isShowCheckmark {
                    self.checkmarkNode
                } else {
                    self.crossMarkNode
                }

                VLayout {
                    self.toggleFooterButton
                    self.toggleCheckmarkButton
                }
            }
            .spacing(20)
            .justifyContent(.center)
            .build()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleCheckmark(_ sender: ASButtonNode) {
        if sender == toggleFooterButton {
            self.isShowFooter.toggle()
        } else if sender == toggleCheckmarkButton {
            self.isShowCheckmark.toggle()
        }
        
        node.setNeedsLayout()
    }
    
    func nativeTextureLayoutSpec() -> ASStackLayoutSpec {
        var mainChildren:[ASLayoutElement] = [nodes[0], nodes[1]]
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.spacing = 20
        horizontalStack.justifyContent = .center
        horizontalStack.children = [nodes[2], nodes[3]]
        mainChildren.append(horizontalStack)
        
        if self.isShowFooter {
            mainChildren.append(self.descriptionNode)
        }
        
        if self.isShowCheckmark {
            mainChildren.append(self.checkmarkNode)
        } else {
            mainChildren.append(self.crossMarkNode)
        }
        
        mainChildren.insert(contentsOf: [self.toggleFooterButton,
                                         toggleCheckmarkButton],
                            at: mainChildren.count - 1)
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.spacing = 20
        verticalStack.justifyContent = .center
        verticalStack.children = mainChildren
        
        return verticalStack
    }
}

