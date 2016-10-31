//
//  HBoxExampleViewController.swift
//  LayoutComposer
//
//  Created by Yusuke Kawakami on 2015/08/22.
//  Copyright (c) 2015年 CocoaPods. All rights reserved.
//

import UIKit
import LayoutComposer

enum HBoxExampleType: Int {
    case basic
    case margin
    case defaultMargin
    case flex
    case alignStart
    case alignEnd
    case alignCenter
    case alignStretch
    case alignEachComponent
    case packStart
    case packEnd
    case packCenter
    case packFit
}

class HBoxExampleViewController: ExampleViewController {
    let exampleType: HBoxExampleType

    init(exampleType: HBoxExampleType, headerTitle: String) {
        self.exampleType = exampleType
        super.init(headerTitle: headerTitle)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func loadView() {
        super.loadView()
        switch exampleType {
        case .basic:
            layoutExampleBasic()
        case .margin:
            layoutExampleMargin()
        case .defaultMargin:
            layoutExampleDefaultMargin()
        case .flex:
            layoutExampleFlex()
        case .alignStart:
            layoutExampleAlignStart()
        case .alignEnd:
            layoutExampleAlignEnd()
        case .alignCenter:
            layoutExampleAlignCenter()
        case .alignStretch:
            layoutExampleAlignStretch()
        case .alignEachComponent:
            layoutExampleAlignEachComponent()
        case .packStart:
            layoutExamplePackStart()
        case .packEnd:
            layoutExamplePackEnd()
        case .packCenter:
            layoutExamplePackCenter()
        case .packFit:
            layoutExamplePackFit()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func layoutExampleBasic() {
        let view1 = makeItemView(title: "view1 width: 50", color: UIColor.red)
        let view2 = makeItemView(title: "view2 width: 100", color: UIColor.green)
        let view3 = makeItemView(title: "view3 width: 75", color: UIColor.blue)

        contentView.applyLayout(HBox(), items: [
            $(view1, width: 50),
            $(view2, width: 100),
            $(view3, width: 75)
        ])
    }

    fileprivate func layoutExampleMargin() {
        let view1 = makeItemView(title: "view1 marginLeft: 10", color: UIColor.red)
        let view2 = makeItemView(title: "view2 marginLeft: 10, marginTop: 20, marginBottom: 30", color: UIColor.green)
        let view3 = makeItemView(title: "view3 margins: (10, 20, 10, 0)", color: UIColor.blue)

        contentView.applyLayout(HBox(), items: [
            $(view1, width: 50, marginLeft: 10),
            $(view2, width: 100, marginTop: 20, marginLeft: 10, marginBottom: 30),
            $(view3, width: 75, margins: (10, 20, 10, 0))
        ])
    }
    
    fileprivate func layoutExampleDefaultMargin() {
        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)
        
        contentView.applyLayout(HBox(defaultMargins: (20, 10, 20, 0)), items: [
            $(view1, width: 50),
            $(view2, width: 100),
            $(view3, width: 75)
            ])
    }

    fileprivate func layoutExampleFlex() {
        let view1 = makeItemView(title: "view1 width: 50", color: UIColor.red)
        let view2 = makeItemView(title: "view2 flex: 1", color: UIColor.green)
        let view3 = makeItemView(title: "view3 flex: 3", color: UIColor.blue)
        let view4 = makeItemView(title: "view3 flex: 2", color: UIColor.yellow)

        contentView.applyLayout(HBox(defaultMargins: (0, 10, 0, 0)), items: [
            $(view1, width: 50),
            $(view2, flex: 1),
            $(view3, flex: 3),
            $(view4, flex: 2)
        ])
    }

    fileprivate func layoutExampleAlignStart() {
        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(HBox(align: .start, defaultMargins: (0, 10, 0, 0)), items: [
            $(view1, width: 50, height: 100),
            $(view2, width: 75, height: 100),
            $(view3, width: 100, height: 200)
        ])
    }

    fileprivate func layoutExampleAlignEnd() {
        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(HBox(align: .end, defaultMargins: (0, 10, 0, 0)), items: [
            $(view1, width: 50, height: 100),
            $(view2, width: 75, height: 100),
            $(view3, width: 100, height: 200)
        ])
    }

    fileprivate func layoutExampleAlignCenter() {
        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(HBox(align: .center, defaultMargins: (0, 10, 0, 0)), items: [
            $(view1, width: 50, height: 100),
            $(view2, width: 75, height: 100),
            $(view3, width: 100, height: 200)
        ])
    }

    fileprivate func layoutExampleAlignStretch() {
        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3 (if height is set align centered)", color: UIColor.blue)

        contentView.applyLayout(HBox(align: .stretch, defaultMargins: (0, 10, 0, 0)), items: [
            $(view1, width: 50),
            $(view2, width: 75),
            $(view3, width: 100, height: 100)
        ])
    }

    fileprivate func layoutExampleAlignEachComponent() {
        let view1 = makeItemView(title: "view1 align: .Start", color: UIColor.red)
        let view2 = makeItemView(title: "view2 align: .Center", color: UIColor.green)
        let view3 = makeItemView(title: "view3 align: .End", color: UIColor.blue)
        let view4 = makeItemView(title: "view4 (Default if height is set)", color: UIColor.yellow)
        let view5 = makeItemView(title: "view5 (Default if height is not set)", color: UIColor.magenta)

        contentView.applyLayout(HBox(defaultMargins: (0, 10, 0, 0)), items: [
            $(view1, height: 200, flex: 1, align: .start),
            $(view2, height: 200, flex: 1, align: .center),
            $(view3, height: 200, flex: 1, align: .end),
            $(view4, height: 200, flex: 1),
            $(view5, flex: 1),
        ])
    }

    fileprivate func layoutExamplePackStart() {
        let container = UIView()
        container.backgroundColor = UIColor.white

        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(VBox(align: .center), item:
            $(container, width: 300, height: 300, layout: HBox(pack: .start, defaultMargins: (0, 10, 0, 0)), items: [
                $(view1, width: 50),
                $(view2, width: 50),
                $(view3, width: 100)
            ])
        )
    }

    fileprivate func layoutExamplePackCenter() {
        let container = UIView()
        container.backgroundColor = UIColor.white

        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(VBox(align: .center), item:
            $(container, width: 300, height: 300, layout: HBox(pack: .center, defaultMargins: (0, 10, 0, 0)), items: [
                $(view1, width: 50),
                $(view2, width: 50),
                $(view3, width: 100)
            ])
        )
    }

    fileprivate func layoutExamplePackEnd() {
        let container = UIView()
        container.backgroundColor = UIColor.white

        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(VBox(align: .center), item:
            $(container, width: 300, height: 300, layout: HBox(pack: .end, defaultMargins: (0, 10, 0, 0)), items: [
                $(view1, width: 50),
                $(view2, width: 50),
                $(view3, width: 100)
            ])
        )
    }

    fileprivate func layoutExamplePackFit() {
        let container = UIView()
        container.backgroundColor = UIColor.white

        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(VBox(align: .center), item:
            $(container, height: 300, layout: HBox(pack: .fit, defaultMargins: (0, 10, 0, 0)), items: [ // container width is adjusted to fit items.
                $(view1, width: 50),
                $(view2, width: 50),
                $(view3, width: 100)
            ])
        )
    }
}
