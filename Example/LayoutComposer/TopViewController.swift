//
//  TopViewController.swift
//  LayoutComposer
//
//  Created by Yusuke Kawakami on 08/22/2015.
//  Copyright (c) 2015 Yusuke Kawakami. All rights reserved.
//

import UIKit
import LayoutComposer

class TopViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func loadView() {
        doLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func doLayout() {
        view = UIView()
        view.backgroundColor = UIColor.white

        let header = UIView()
        header.backgroundColor = UIColor.black

        let titleLabel = UILabel()
        titleLabel.text = "LayoutComposer Examples"
        titleLabel.textColor = UIColor.white

        let scrollView = UIScrollView()

        view.applyLayout(VBox(), items: [
            $(header, height: 65, layout: Relative(), item:
                $(titleLabel, halign: .center, marginTop: 20)
            ),
            $(scrollView, flex: 1, layout: VBox(align: .center, pack: .fit, defaultMargins: (10, 0, 0, 0)), items: [
                $(makeButton(title: "VBox Basic", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.basic.rawValue)),
                $(makeButton(title: "VBox Margin", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.margin.rawValue)),
                $(makeButton(title: "VBox Default Margin", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.defaultMargin.rawValue)),
                $(makeButton(title: "VBox Flex Height", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.flex.rawValue)),
                $(makeButton(title: "VBox Align Start(Left)", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.alignStart.rawValue)),
                $(makeButton(title: "VBox Align End(Right)", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.alignEnd.rawValue)),
                $(makeButton(title: "VBox Align Center", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.alignCenter.rawValue)),
                $(makeButton(title: "VBox Align Stretch", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.alignStretch.rawValue)),
                $(makeButton(title: "VBox Align Each Component", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.alignEachComponent.rawValue)),
                $(makeButton(title: "VBox Pack Start(Top)", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.packStart.rawValue)),
                $(makeButton(title: "VBox Pack End(Bottom)", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.packEnd.rawValue)),
                $(makeButton(title: "VBox Pack Center", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.packCenter.rawValue)),
                $(makeButton(title: "VBox Pack Fit", action: #selector(TopViewController.onVBoxExampleTapped(_:)), tag: VBoxExampleType.packFit.rawValue)),

                $(makeButton(title: "HBox Basic", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.basic.rawValue)),
                $(makeButton(title: "HBox Margin", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.margin.rawValue)),
                $(makeButton(title: "HBox Default Margin", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.defaultMargin.rawValue)),
                $(makeButton(title: "HBox Flex Width", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.flex.rawValue)),
                $(makeButton(title: "HBox Align Start(Top)", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.alignStart.rawValue)),
                $(makeButton(title: "HBox Align End(Bottom)", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.alignEnd.rawValue)),
                $(makeButton(title: "HBox Align Center", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.alignCenter.rawValue)),
                $(makeButton(title: "HBox Align Stretch", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.alignStretch.rawValue)),
                $(makeButton(title: "HBox Align Each Component", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.alignEachComponent.rawValue)),
                $(makeButton(title: "HBox Pack Start(Left)", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.packStart.rawValue)),
                $(makeButton(title: "HBox Pack End(Right)", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.packEnd.rawValue)),
                $(makeButton(title: "HBox Pack Center", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.packCenter.rawValue)),
                $(makeButton(title: "HBox Pack Fit", action: #selector(TopViewController.onHBoxExampleTapped(_:)), tag: HBoxExampleType.packFit.rawValue)),
                
                $(makeButton(title: "Relative 1", action: #selector(TopViewController.onRelativeExampleTapped(_:)), tag: RelativeExampleType.example1.rawValue)),
                $(makeButton(title: "Relative 2", action: #selector(TopViewController.onRelativeExampleTapped(_:)), tag: RelativeExampleType.example2.rawValue)),
                $(makeButton(title: "Relative 3", action: #selector(TopViewController.onRelativeExampleTapped(_:)), tag: RelativeExampleType.example3.rawValue)),
                
                $(makeButton(title: "Fit", action: #selector(TopViewController.onFitExampleTapped(_:)), tag: FitExampleType.example1.rawValue)),
                
                $(makeButton(title: "Nesting Layout", action: #selector(TopViewController.onNestExampleTapped(_:)), tag: NestExampleType.example1.rawValue))
            ])
        ])
    }

    fileprivate func makeButton(title: String, action: Selector, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: UIControlState())
        button.addTarget(self, action: action, for: .touchUpInside)
        button.tag = tag
        return button
    }

    func onVBoxExampleTapped(_ sender: UIButton) {
        if let title = sender.title(for: UIControlState()),
            let exampleType = VBoxExampleType(rawValue: sender.tag)
        {
            let vc = VBoxExampleViewController(exampleType: exampleType, headerTitle: title)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func onHBoxExampleTapped(_ sender: UIButton) {
        if let title = sender.title(for: UIControlState()),
            let exampleType = HBoxExampleType(rawValue: sender.tag)
        {
            let vc = HBoxExampleViewController(exampleType: exampleType, headerTitle: title)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func onRelativeExampleTapped(_ sender: UIButton) {
        if let title = sender.title(for: UIControlState()),
            let exampleType = RelativeExampleType(rawValue: sender.tag)
        {
            let vc = RelativeExampleViewController(exampleType: exampleType, headerTitle: title)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func onFitExampleTapped(_ sender: UIButton) {
        if let title = sender.title(for: UIControlState()),
            let exampleType = FitExampleType(rawValue: sender.tag)
        {
            let vc = FitExampleViewController(exampleType: exampleType, headerTitle: title)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func onNestExampleTapped(_ sender: UIButton) {
        if let title = sender.title(for: UIControlState()),
            let exampleType = NestExampleType(rawValue: sender.tag)
        {
            let vc = NestExampleViewController(exampleType: exampleType, headerTitle: title)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
