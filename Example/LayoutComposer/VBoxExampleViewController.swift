//
//  VBoxExampleViewController.swift
//  LayoutComposer
//
//  Created by Yusuke Kawakami on 2015/08/22.
//  Copyright (c) 2015年 CocoaPods. All rights reserved.
//

import UIKit
import LayoutComposer

enum VBoxExampleType: Int {
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

class VBoxExampleViewController: ExampleViewController {
    let exampleType: VBoxExampleType

    init(exampleType: VBoxExampleType, headerTitle: String) {
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
        let view1 = makeItemView(title: "view1 height: 50", color: UIColor.red)
        let view2 = makeItemView(title: "view2 height: 100", color: UIColor.green)
        let view3 = makeItemView(title: "view3 flex: 1", color: UIColor.blue)
        let view4 = makeItemView(title: "view4 flex: 2", color: UIColor.yellow)

        contentView.applyLayout(VBox(), items: [
            $(view1, height: 50),
            $(view2, height: 100),
            $(view3, flex: 1),
            $(view4, flex: 2)
        ])
    }

    fileprivate func layoutExampleMargin() {
        let view1 = makeItemView(title: "view1 marginTop: 10", color: UIColor.red)
        let view2 = makeItemView(title: "view2 marginTop: 10, marginLeft: 20, marginRight: 30", color: UIColor.green)
        let view3 = makeItemView(title: "view3 margins: (10, 30, 0, 20)", color: UIColor.blue)

        contentView.applyLayout(VBox(), items: [
            $(view1, height: 50, marginTop: 10),
            $(view2, height: 100, marginTop: 10, marginLeft: 20, marginRight: 30),
            $(view3, height: 75, margins: (10, 30, 0, 20))
        ])
    }
    
    fileprivate func layoutExampleDefaultMargin() {
        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)
        
        contentView.applyLayout(VBox(defaultMargins: (10, 20, 0, 20)), items: [
            $(view1, height: 50),
            $(view2, height: 100),
            $(view3, height: 75)
            ])
    }

    fileprivate func layoutExampleFlex() {
        let view1 = makeItemView(title: "view1 height: 50", color: UIColor.red)
        let view2 = makeItemView(title: "view2 flex: 1", color: UIColor.green)
        let view3 = makeItemView(title: "view3 flex: 3", color: UIColor.blue)
        let view4 = makeItemView(title: "view3 flex: 2", color: UIColor.yellow)

        contentView.applyLayout(VBox(defaultMargins: (10, 20, 0, 20)), items: [
            $(view1, height: 50),
            $(view2, flex: 1),
            $(view3, flex: 3),
            $(view4, flex: 2)
        ])
    }

    fileprivate func layoutExampleAlignStart() {
        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(VBox(align: .start, defaultMargins: (10, 0, 0, 0)), items: [
            $(view1, width: 50, height: 50),
            $(view2, width: 100, height: 50),
            $(view3, width: 200, height: 100)
        ])
    }

    fileprivate func layoutExampleAlignEnd() {
        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(VBox(align: .end, defaultMargins: (10, 0, 0, 0)), items: [
            $(view1, width: 50, height: 50),
            $(view2, width: 100, height: 50),
            $(view3, width: 200, height: 100)
        ])
    }

    fileprivate func layoutExampleAlignCenter() {
        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(VBox(align: .center, defaultMargins: (10, 0, 0, 0)), items: [
            $(view1, width: 50, height: 50),
            $(view2, width: 100, height: 50),
            $(view3, width: 200, height: 100)
        ])
    }

    fileprivate func layoutExampleAlignStretch() {
        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3 (if width is set align centered)", color: UIColor.blue)

        contentView.applyLayout(VBox(align: .stretch, defaultMargins: (10, 0, 0, 0)), items: [
            $(view1, height: 50),
            $(view2, height: 50),
            $(view3, width: 250, height: 100)
            ])
    }

    fileprivate func layoutExampleAlignEachComponent() {
        let view1 = makeItemView(title: "view1 align: .Start", color: UIColor.red)
        let view2 = makeItemView(title: "view2 align: .Center", color: UIColor.green)
        let view3 = makeItemView(title: "view3 align: .End", color: UIColor.blue)
        let view4 = makeItemView(title: "view4 (Default if width is set)", color: UIColor.yellow)
        let view5 = makeItemView(title: "view5 (Default if width is not set)", color: UIColor.magenta)

        contentView.applyLayout(VBox(defaultMargins: (10, 0, 0, 0)), items: [
            $(view1, width: 200, flex: 1, align: .start),
            $(view2, width: 200, flex: 1, align: .center),
            $(view3, width: 200, flex: 1, align: .end),
            $(view4, width: 200, flex: 1),
            $(view5, flex: 1),
        ])
    }

    fileprivate func layoutExamplePackStart() {
        let container = UIView()
        container.backgroundColor = UIColor.white

        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(VBox(), item:
            $(container, height: 400, layout: VBox(pack: .start, defaultMargins: (10, 0, 0, 0)), items: [
                $(view1, height: 50),
                $(view2, height: 50),
                $(view3, height: 100)
            ])
        )
    }

    fileprivate func layoutExamplePackCenter() {
        let container = UIView()
        container.backgroundColor = UIColor.white

        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(VBox(), item:
            $(container, height: 400, layout: VBox(pack: .center, defaultMargins: (10, 0, 0, 0)), items: [
                $(view1, height: 50),
                $(view2, height: 50),
                $(view3, height: 100)
            ])
        )
    }

    fileprivate func layoutExamplePackEnd() {
        let container = UIView()
        container.backgroundColor = UIColor.white

        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(VBox(), item:
            $(container, height: 400, layout: VBox(pack: .end, defaultMargins: (10, 0, 0, 0)), items: [
                $(view1, height: 50),
                $(view2, height: 50),
                $(view3, height: 100)
            ])
        )
    }

    fileprivate func layoutExamplePackFit() {
        let container = UIView()
        container.backgroundColor = UIColor.white

        let view1 = makeItemView(title: "view1", color: UIColor.red)
        let view2 = makeItemView(title: "view2", color: UIColor.green)
        let view3 = makeItemView(title: "view3", color: UIColor.blue)

        contentView.applyLayout(VBox(), item:
            $(container, layout: VBox(pack: .fit, defaultMargins: (10, 0, 0, 0)), items: [ // container height is adjusted to fit items.
                $(view1, height: 50),
                $(view2, height: 50),
                $(view3, height: 100)
            ])
        )
    }
}
