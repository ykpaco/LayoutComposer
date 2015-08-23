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
    case Basic = 1
    case Margin = 2
    case Flex = 3
    case AlignStart = 4
    case AlignEnd = 5
    case AlignCenter = 6
    case AlignStretch = 7
    case AlignEachComponent = 8
    case PackStart = 9
    case PackEnd = 10
    case PackCenter = 11
    case PackFit = 12
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
        case .Basic:
            layoutExampleBasic()
        case .Margin:
            layoutExampleMargin()
        case .Flex:
            layoutExampleFlex()
        case .AlignStart:
            layoutExampleAlignStart()
        case .AlignEnd:
            layoutExampleAlignEnd()
        case .AlignCenter:
            layoutExampleAlignCenter()
        case .AlignStretch:
            layoutExampleAlignStretch()
        case .AlignEachComponent:
            layoutExampleAlignEachComponent()
        case .PackStart:
            layoutExamplePackStart()
        case .PackEnd:
            layoutExamplePackEnd()
        case .PackCenter:
            layoutExamplePackCenter()
        case .PackFit:
            layoutExamplePackFit()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func layoutExampleBasic() {
        let view1 = makeItemView(title: "view1 width: 50", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2 width: 100", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3 width: 75", color: UIColor.blueColor())

        contentView.applyLayout(HBox(), items: [
            $(view1, width: 50),
            $(view2, width: 100),
            $(view3, width: 75)
        ])
    }

    private func layoutExampleMargin() {
        let view1 = makeItemView(title: "view1 marginLeft: 10", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2 marginLeft: 10, marginTop: 20, marginBottom: 30", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3 margins: (10, 20, 10, 0)", color: UIColor.blueColor())

        contentView.applyLayout(HBox(), items: [
            $(view1, width: 50, marginLeft: 10),
            $(view2, width: 100, marginLeft: 10, marginTop: 20, marginBottom: 30),
            $(view3, width: 75, margins: (10, 20, 10, 0))
        ])
    }

    private func layoutExampleFlex() {
        let view1 = makeItemView(title: "view1 width: 50", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2 flex: 1", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3 flex: 3", color: UIColor.blueColor())
        let view4 = makeItemView(title: "view3 flex: 2", color: UIColor.yellowColor())

        contentView.applyLayout(HBox(), items: [
            $(view1, width: 50),
            $(view2, flex: 1),
            $(view3, flex: 3),
            $(view4, flex: 2)
        ])
    }

    private func layoutExampleAlignStart() {
        let view1 = makeItemView(title: "view1", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3", color: UIColor.blueColor())

        contentView.applyLayout(HBox(align: .Start), items: [
            $(view1, width: 50, height: 100),
            $(view2, width: 75, height: 100),
            $(view3, width: 100, height: 200)
        ])
    }

    private func layoutExampleAlignEnd() {
        let view1 = makeItemView(title: "view1", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3", color: UIColor.blueColor())

        contentView.applyLayout(HBox(align: .End), items: [
            $(view1, width: 50, height: 100),
            $(view2, width: 75, height: 100),
            $(view3, width: 100, height: 200)
        ])
    }

    private func layoutExampleAlignCenter() {
        let view1 = makeItemView(title: "view1", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3", color: UIColor.blueColor())

        contentView.applyLayout(HBox(align: .Center), items: [
            $(view1, width: 50, height: 100),
            $(view2, width: 75, height: 100),
            $(view3, width: 100, height: 200)
        ])
    }

    private func layoutExampleAlignStretch() {
        let view1 = makeItemView(title: "view1", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3 (if width is set align centered)", color: UIColor.blueColor())

        contentView.applyLayout(HBox(align: .Stretch), items: [
            $(view1, width: 50),
            $(view2, width: 75),
            $(view3, width: 100)
        ])
    }

    private func layoutExampleAlignEachComponent() {
        let view1 = makeItemView(title: "view1 align: .Start", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2 align: .Center", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3 align: .End", color: UIColor.blueColor())
        let view4 = makeItemView(title: "view4 (Default if height is set)", color: UIColor.yellowColor())
        let view5 = makeItemView(title: "view5 (Default if height is not set)", color: UIColor.magentaColor())

        contentView.applyLayout(HBox(), items: [
            $(view1, height: 200, flex: 1, align: .Start),
            $(view2, height: 200, flex: 1, align: .Center),
            $(view3, height: 200, flex: 1, align: .End),
            $(view4, height: 200, flex: 1),
            $(view5, flex: 1),
        ])
    }

    private func layoutExamplePackStart() {
        let container = UIView()
        container.backgroundColor = UIColor.whiteColor()

        let view1 = makeItemView(title: "view1", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3", color: UIColor.blueColor())

        contentView.applyLayout(VBox(align: .Center), item:
            $(container, width: 300, height: 300, layout: HBox(pack: .Start), items: [
                $(view1, width: 50),
                $(view2, width: 50),
                $(view3, width: 100)
            ])
        )
    }

    private func layoutExamplePackCenter() {
        let container = UIView()
        container.backgroundColor = UIColor.whiteColor()

        let view1 = makeItemView(title: "view1", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3", color: UIColor.blueColor())

        contentView.applyLayout(VBox(align: .Center), item:
            $(container, width: 300, height: 300, layout: HBox(pack: .Center), items: [
                $(view1, width: 50),
                $(view2, width: 50),
                $(view3, width: 100)
            ])
        )
    }

    private func layoutExamplePackEnd() {
        let container = UIView()
        container.backgroundColor = UIColor.whiteColor()

        let view1 = makeItemView(title: "view1", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3", color: UIColor.blueColor())

        contentView.applyLayout(VBox(align: .Center), item:
            $(container, width: 300, height: 300, layout: HBox(pack: .End), items: [
                $(view1, width: 50),
                $(view2, width: 50),
                $(view3, width: 100)
            ])
        )
    }

    private func layoutExamplePackFit() {
        let container = UIView()
        container.backgroundColor = UIColor.whiteColor()

        let view1 = makeItemView(title: "view1", color: UIColor.redColor())
        let view2 = makeItemView(title: "view2", color: UIColor.greenColor())
        let view3 = makeItemView(title: "view3", color: UIColor.blueColor())

        contentView.applyLayout(VBox(align: .Center), item:
            $(container, height: 300, layout: HBox(pack: .Fit), items: [ // container width is adjusted to fit items.
                $(view1, width: 50),
                $(view2, width: 50),
                $(view3, width: 100)
            ])
        )
    }
}
