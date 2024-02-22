//
//  ViewController.swift
//  YYUIKitDemo
//
//  Created by 渠晓友 on 2024/2/4.
//

import UIKit
import XYInfomationSection
import YYUIKit
import YYImage
import SwiftUI
import XYNav

class ViewController: XYInfomationBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    // UIViewController.Type or SwiftUI.View
    let dataModel: [[String: Any]] =
        [
            ["自定义 loading": TableViewController.self],
            ["自定义 view": ViewController2.self],
            ["自定义各种悬浮球": FloatBallView()],
        ]
    
}

extension ViewController {
    
    func buildUI() {
        title = "YYUIKit"
        view.backgroundColor = .random
        
        setupContent()
    }
    
    func setupContent() {
        setContentWithData(contentData(), itemConfig: { item in
            item.titleWidthRate = 0.5
            item.type = .choose
            item.value = " "
        }, sectionConfig: { section in
            section.corner(radius: 5)
        }, sectionDistance: 0, contentEdgeInsets: .init(top: 10, left: 10, bottom: 0, right: 10)) {[weak self] index, cell in
            guard let self = self else { return }
            
            if let vcType = cell.model.obj as? UIViewController.Type {
                let detailVC = vcType.init()
                detailVC.title = cell.model.title
                self.nav_push(detailVC, animated: true)
                XYNavigationController.showClassNameByDefault(true)
            } else if let view = cell.model.obj as? (any View) {
                let detailVC = UIHostingController(rootView: AnyView(view))
                detailVC.title = cell.model.title
                self.nav_push(detailVC, animated: true)
                XYNavigationController.showClassNameByDefault(false)
            }
        }
    }
}

extension ViewController {
    
    func contentData() -> [Any] {
        var result = [Any]()
        
        var section: [[String: Any]] = []
        dataModel.forEach { dic in
            section.append(["title": dic.keys.first ?? "", "obj": dic.values.first ?? ""])
        }
        result.append(section)
        return result
    }
}

