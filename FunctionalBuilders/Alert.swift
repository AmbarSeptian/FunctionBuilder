//
//  Action.swift
//  Example
//
//  Created by Ambar Septian on 15/06/20.
//  Copyright © 2020 KKBOX. All rights reserved.
//

import UIKit

struct Action {
    let title: String
    let style: UIAlertAction.Style
    let action: () -> Void
}

extension Action {
    static func `default`(_ title: String, action: @escaping () -> Void) -> [Action] {
        return [Action(title: title, style: .default, action: action)]
    }

    static func destructive(_ title: String, action: @escaping () -> Void) -> [Action] {
        return [Action(title: title, style: .destructive, action: action)]
    }

    static func cancel(_ title: String, action: @escaping () -> Void = {}) -> [Action] {
        return [Action(title: title, style: .cancel, action: action)]
    }
}

func makeAlertController(title: String,
                         message: String,
                         style: UIAlertController.Style,
                         actions: [Action]) -> UIAlertController {
    let controller = UIAlertController(
        title: title,
        message: message,
        preferredStyle: style
    )
    for action in actions {
        let uiAction = UIAlertAction(title: action.title, style: action.style) { _ in
            action.action()
        }
        controller.addAction(uiAction)
    }
    return controller
}

@_functionBuilder
struct ActionBuilder {

    typealias Component = [Action]

    static func buildBlock(_ children: Component...) -> Component {
        return children.flatMap { $0 }
    }

    static func buildIf(_ component: Component?) -> Component {
        return component ?? []
    }

    static func buildEither(first component: Component) -> Component {
        print(">>>First")
        return component
    }

    static func buildEither(second component: Component) -> Component {
        print(">>>Second")
        return component
    }
//
    static func buildEither(third component: Component) -> Component {
        print(">>>Third")
        return component
    }

    static func buildEither(fourth component: Component) -> Component {
        print(">>>Fourth")
        return component
    }
    
}

func Alert(title: String,
           message: String,
           @ActionBuilder _ makeActions: () -> [Action]) -> UIAlertController {
    makeAlertController(
        title: title,
        message: message,
        style: .alert,
        actions: makeActions()
    )
}

func ActionSheet(title: String,
                 message: String,
                 @ActionBuilder _ makeActions: () -> [Action]) -> UIAlertController {
    makeAlertController(
        title: title,
        message: message,
        style: .actionSheet,
        actions: makeActions()
    )
}

func ForIn<S: Sequence>(_ sequence: S,
                        @ActionBuilder makeActions: (S.Element) -> [Action]) -> [Action] {
    return sequence
        .map(makeActions) // of type [[Action]]
        .flatMap { $0 }   // of type [Action]
}

let canEdit = false
let asdf = false
let sdf = false
let alertController = Alert(title: "Deletion", message: "Are you sure?") {
    Action.default("Delete") { /* ... */ }
    if canEdit {
        Action.destructive("Edit") { /* ... */ }
    } else if asdf {
        Action.destructive("Share") { /* ... */ }
    } else if sdf {
        Action.destructive("AAAA") { /* ... */ }
    } else {
        Action.destructive("ASDf") { /* ... */ }
    }
    Action.cancel("Cancel")
}

let dynamicAlertController = Alert(title: "Title", message: "Message") {
    ForIn(["Action1", "Action2"]) { string in
        Action.default(string) { print(string) }
    }
}
