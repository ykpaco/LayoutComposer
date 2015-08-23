//
//  LayoutComposer.swift
//
//  Copyright (c) 2014-2015 Yusuke Kawakami
//
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

import UIKit

public enum BoxLayoutAlign {
    case Stretch // Default
    case Start
    case Center
    case End
}

public enum BoxLayoutPack {
    case Start
    case Center
    case End
    case Fit
}

public class Layout {
    let defaultMargins: UIEdgeInsets

    public init(defaultMargins: UIEdgeInsets) {
        self.defaultMargins = defaultMargins
    }
}

public class VBox: Layout {
    let align: BoxLayoutAlign
    let pack: BoxLayoutPack

    public init(align: BoxLayoutAlign = .Stretch, pack: BoxLayoutPack = .Start, defaultMargins: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)) {
        self.align = align
        self.pack = pack
        super.init(defaultMargins: UIEdgeInsetsMake(defaultMargins.0, defaultMargins.1, defaultMargins.2, defaultMargins.3))
    }
}

public class HBox: Layout {
    let align: BoxLayoutAlign
    let pack: BoxLayoutPack

    public init(align: BoxLayoutAlign = .Stretch, pack: BoxLayoutPack = .Start, defaultMargins: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)) {
        self.align = align
        self.pack = pack
        super.init(defaultMargins: UIEdgeInsetsMake(defaultMargins.0, defaultMargins.1, defaultMargins.2, defaultMargins.3))
    }
}

public enum RelativeLayoutVAlign {
    case Top
    case Center
    case Bottom
}

public enum RelativeLayoutHAlign {
    case Left
    case Center
    case Right
}

public class Relative: Layout {
    public init(defaultMargins: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)) {
        super.init(defaultMargins: UIEdgeInsetsMake(defaultMargins.0, defaultMargins.1, defaultMargins.2, defaultMargins.3))
    }
}

public class Fit: Layout {
    public init(defaultMargins: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)) {
        super.init(defaultMargins: UIEdgeInsetsMake(defaultMargins.0, defaultMargins.1, defaultMargins.2, defaultMargins.3))
    }
}

public class LayoutComponent {
    public let view: UIView
    private var width: CGFloat?
    private var height: CGFloat?
    public let flex: CGFloat?
    public let layout: Layout?
    public let marginTop: CGFloat?
    public let marginLeft: CGFloat?
    public let marginBottom: CGFloat?
    public let marginRight: CGFloat?
    public let align: BoxLayoutAlign?
    public let halign: RelativeLayoutHAlign?
    public let valign: RelativeLayoutVAlign?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?

    public init(view: UIView,
        width: CGFloat?,
        height: CGFloat?,
        flex: CGFloat?,
        layout: Layout?,
        margins: (CGFloat, CGFloat, CGFloat, CGFloat)?,
        marginTop: CGFloat?,
        marginLeft: CGFloat?,
        marginBottom: CGFloat?,
        marginRight: CGFloat?,
        align: BoxLayoutAlign?,
        halign: RelativeLayoutHAlign?,
        valign: RelativeLayoutVAlign?,
        widthConstraint: NSLayoutConstraint?,
        heightConstraint: NSLayoutConstraint?) {

            self.view = view
            self.width = width
            self.height = height
            self.flex = flex
            self.layout = layout

            self.marginTop = marginTop ?? margins?.0
            self.marginLeft = marginLeft ?? margins?.1
            self.marginBottom = marginBottom ?? margins?.2
            self.marginRight = marginRight ?? margins?.3

            self.align = align
            self.halign = halign
            self.valign = valign
            self.widthConstraint = widthConstraint
            self.heightConstraint = heightConstraint
    }

    public func updateWidth(width: CGFloat) {
        if let constraint = widthConstraint {
            view.removeConstraint(constraint)
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Width,
            multiplier: 1.0,
            constant: width)
        view.addConstraint(constraint)
        widthConstraint = constraint
        self.width = width
    }

    public func updateHeight(height: CGFloat) {
        if let constraint = heightConstraint {
            view.removeConstraint(constraint)
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Height,
            multiplier: 1.0,
            constant: height)
        view.addConstraint(constraint)
        heightConstraint = constraint
        self.height = height
    }
}

public func $(view: UIView?,
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    flex: CGFloat? = nil,
    layout: Layout? = nil,
    margins: (CGFloat, CGFloat, CGFloat, CGFloat)? = nil,
    marginTop: CGFloat? = nil,
    marginLeft: CGFloat? = nil,
    marginBottom: CGFloat? = nil,
    marginRight: CGFloat? = nil,
    align: BoxLayoutAlign? = nil,
    halign: RelativeLayoutHAlign? = nil,
    valign: RelativeLayoutVAlign? = nil,
    #item: LayoutComponent) -> LayoutComponent {

        return $(view,
            width: width,
            height: height,
            flex: flex,
            layout: layout,
            margins: margins,
            marginTop: marginTop,
            marginLeft: marginLeft,
            marginBottom: marginBottom,
            marginRight: marginRight,
            align: align,
            halign: halign,
            valign: valign,
            items: [item])
}

// Create a new layouted view or apply layout to view.
public func $(view: UIView?,
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    flex: CGFloat? = nil,
    layout: Layout? = nil,
    margins: (CGFloat, CGFloat, CGFloat, CGFloat)? = nil,
    marginTop: CGFloat? = nil,
    marginLeft: CGFloat? = nil,
    marginBottom: CGFloat? = nil,
    marginRight: CGFloat? = nil,
    align: BoxLayoutAlign? = nil,
    halign: RelativeLayoutHAlign? = nil,
    valign: RelativeLayoutVAlign? = nil,
    items: [LayoutComponent]? = nil) -> LayoutComponent {

        let container = view ?? UIView()
        let (widthConstraint, heightConstraint) = container.setSizeConstraint(width:width, height: height)

        if let _layout = layout, _items = items {
            switch _layout {
            case let vbox as VBox:
                 addItemsToContainerWithVBox(container, vbox, _items)
            case let hbox as HBox:
                addItemsToContainerWithHBox(container, hbox, _items)
            case let relative as Relative:
                addItemsToContainerWithRelative(container, relative, _items)
            case let fit as Fit:
                addItemsToContainerWithFit(container, fit, _items)
            default:
                break
            }
        }
        return LayoutComponent(view: container,
            width: width,
            height: height,
            flex: flex,
            layout: layout,
            margins: margins,
            marginTop: marginTop,
            marginLeft: marginLeft,
            marginBottom: marginBottom,
            marginRight: marginRight,
            align: align,
            halign: halign,
            valign: valign,
            widthConstraint: widthConstraint,
            heightConstraint: heightConstraint)
}

private func addItemsToContainerWithVBox(container: UIView, layout: VBox, items: [LayoutComponent]) {
    var hasFlex = false
    var minFlex:CGFloat?
    var minFlexItem: LayoutComponent?
    for item in items {
        container.addSubview(item.view)
        if let flex = item.flex {
            if let _minFlex = minFlex {
                if flex < _minFlex {
                    minFlex = flex
                    minFlexItem = item
                }
            }
            else {
                minFlex = flex
                minFlexItem = item
            }
        }
        item.view.setTranslatesAutoresizingMaskIntoConstraints(false)
    }

    if minFlexItem != nil && minFlex != nil || layout.pack == .Fit {
        // if pack attribute is set to Fit, or the item's flex is set,
        // the container height is adjusted to contain the items.
        if let firstItem = items.first {
            let topMargin:CGFloat = firstItem.marginTop ?? layout.defaultMargins.top
            let leadingConstraint = NSLayoutConstraint(
                item: firstItem.view,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: container,
                attribute: .Top,
                multiplier: 1.0,
                constant: topMargin)
            container.addConstraint(leadingConstraint)
        }
        if let lastItem = items.last {
            let bottomMargin:CGFloat = lastItem.marginBottom ?? layout.defaultMargins.bottom
            let trailingConstraint = NSLayoutConstraint(
                item: lastItem.view,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: container,
                attribute: .Bottom,
                multiplier: 1.0,
                constant: -bottomMargin)
            container.addConstraint(trailingConstraint)
        }
    }
    else if layout.pack == .Start {
        // Top aligned.
        if let firstItem = items.first {
            let topMargin:CGFloat = firstItem.marginTop ?? layout.defaultMargins.top
            let leadingConstraint = NSLayoutConstraint(
                item: firstItem.view,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: container,
                attribute: .Top,
                multiplier: 1.0,
                constant: topMargin)
            container.addConstraint(leadingConstraint)
        }
    }
    else if layout.pack == .End {
        // Bottom aligned.
        if let lastItem = items.last {
            let bottomMargin:CGFloat = lastItem.marginBottom ?? layout.defaultMargins.bottom
            let trailingConstraint = NSLayoutConstraint(
                item: lastItem.view,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: container,
                attribute: .Bottom,
                multiplier: 1.0,
                constant: -bottomMargin)
            container.addConstraint(trailingConstraint)
        }
    }
    else if layout.pack == .Center {
        // insert spacers of the same height to add mergins to above and below the items.
        let topSpacer = createTopSpacer(container)
        let bottomSpacer = createBottomSpacer(container)
        let equalHeightSpacerConstraint = NSLayoutConstraint(
            item: bottomSpacer,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: topSpacer,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0.0)
        container.addConstraint(equalHeightSpacerConstraint)

        if let firstItem = items.first {
            let leadingConstraint = NSLayoutConstraint(
                item: firstItem.view,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: topSpacer,
                attribute: .Bottom,
                multiplier: 1.0,
                constant: 0.0)
            container.addConstraint(leadingConstraint)
        }
        if let lastItem = items.last {
            let trailingConstraint = NSLayoutConstraint(
                item: lastItem.view,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: bottomSpacer,
                attribute: .Top,
                multiplier: 1.0,
                constant: 0.0)
            container.addConstraint(trailingConstraint)
        }
    }

    var prevItem: LayoutComponent? = nil
    for item in items {
        // Flex settings.
        if let flex = item.flex {
            if let _minFlexItem = minFlexItem, _minFlex = minFlex {
                if item !== _minFlexItem {
                    let sizeRatioConstraint = NSLayoutConstraint(
                        item: item.view,
                        attribute: .Height,
                        relatedBy: .Equal,
                        toItem: _minFlexItem.view,
                        attribute: .Height,
                        multiplier: CGFloat(flex/_minFlex),
                        constant:0.0)
                    container.addConstraint(sizeRatioConstraint)
                }
            }
        }
        // Set mergin to the previous component.
        if let _prevItem = prevItem {
            let topMargin:CGFloat = (_prevItem.marginBottom ?? layout.defaultMargins.bottom) + (item.marginTop ?? layout.defaultMargins.top)
            let leadingConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: _prevItem.view,
                attribute: .Bottom,
                multiplier: 1.0,
                constant: topMargin)
            container.addConstraint(leadingConstraint)
        }

        // Alignent.
        // Start: Left aligned, Center: Center aligned, End: Right aligned.
        let align = item.align ?? layout.align
        if align == .Start {
            let leftMargin:CGFloat = item.marginLeft ?? layout.defaultMargins.left
            let leftConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: container,
                attribute: .Left,
                multiplier: 1.0,
                constant: leftMargin)
            container.addConstraint(leftConstraint)
        }
        else if align == .End {
            let rightMargin:CGFloat = item.marginRight ?? layout.defaultMargins.right
            let rightConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: container,
                attribute: .Right,
                multiplier: 1.0,
                constant: -rightMargin)
            container.addConstraint(rightConstraint)
        }
        else if align == .Center {
            let centerConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .CenterX,
                relatedBy: .Equal,
                toItem: container,
                attribute: .CenterX,
                multiplier: 1.0,
                constant: 0.0)
            container.addConstraint(centerConstraint)
        }
        else if align == .Stretch {
            if let widthConstraint = getWidthConstraintOfView(item.view) {
                //
                // if width constraint is set, align centered.
                //
                let centerConstraint = NSLayoutConstraint(
                    item: item.view,
                    attribute: .CenterX,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .CenterX,
                    multiplier: 1.0,
                    constant: 0.0)
                container.addConstraint(centerConstraint)
            }
            else {
                //
                // if width constraint is not set, expand width to fit parent view.
                //
                let leftMargin:CGFloat = item.marginLeft ?? layout.defaultMargins.left
                let leftConstraint = NSLayoutConstraint(
                    item: item.view,
                    attribute: .Left,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .Left,
                    multiplier: 1.0,
                    constant: leftMargin)
                
                let rightMargin:CGFloat = item.marginRight ?? layout.defaultMargins.right
                let rightConstraint = NSLayoutConstraint(
                    item: item.view,
                    attribute: .Right,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .Right,
                    multiplier: 1.0,
                    constant: -rightMargin)
                
                container.addConstraints([leftConstraint, rightConstraint])
            }
        }
        prevItem = item
    }
}

private func addItemsToContainerWithHBox(container: UIView, layout: HBox, items: [LayoutComponent]) {
    var hasFlex = false
    var minFlex:CGFloat?
    var minFlexItem: LayoutComponent?
    for item in items {
        container.addSubview(item.view)
        if let flex = item.flex {
            if let _minFlex = minFlex {
                if flex < _minFlex {
                    minFlex = flex
                    minFlexItem = item
                }
            }
            else {
                minFlex = flex
                minFlexItem = item
            }
        }
        item.view.setTranslatesAutoresizingMaskIntoConstraints(false)
    }

    if minFlexItem != nil && minFlex != nil || layout.pack == .Fit {
        // if pack attribute is set to Fit, or the item's flex is set,
        // the container width is adjusted to contain the items.
        if let firstItem = items.first {
            let leftMargin:CGFloat = firstItem.marginLeft ?? layout.defaultMargins.left
            let leadingConstraint = NSLayoutConstraint(
                item: firstItem.view,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: container,
                attribute: .Left,
                multiplier: 1.0,
                constant: leftMargin)
            container.addConstraint(leadingConstraint)
        }
        if let lastItem = items.last {
            let rightMargin:CGFloat = lastItem.marginRight ?? layout.defaultMargins.right
            let trailingConstraint = NSLayoutConstraint(
                item: lastItem.view,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: container,
                attribute: .Right,
                multiplier: 1.0,
                constant: -rightMargin)
            container.addConstraint(trailingConstraint)
        }
    }
    else if layout.pack == .Start {
        // Left aligned.
        if let firstItem = items.first {
            let leftMargin:CGFloat = firstItem.marginLeft ?? layout.defaultMargins.left
            let leadingConstraint = NSLayoutConstraint(
                item: firstItem.view,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: container,
                attribute: .Left,
                multiplier: 1.0,
                constant: leftMargin)
            container.addConstraint(leadingConstraint)
        }
    }
    else if layout.pack == .End {
        // Right aligned.
        if let lastItem = items.last {
            let rightMargin:CGFloat = lastItem.marginRight ?? layout.defaultMargins.right
            let trailingConstraint = NSLayoutConstraint(
                item: lastItem.view,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: container,
                attribute: .Right,
                multiplier: 1.0,
                constant: -rightMargin)
            container.addConstraint(trailingConstraint)
        }
    }
    else if layout.pack == .Center {
        // insert spacers of the same width to add mergins to left and right to the items.
        let leftSpacer = createLeftSpacer(container)
        let rightSpacer = createRightSpacer(container)
        let equalWidthSpacerConstraint = NSLayoutConstraint(
            item: leftSpacer,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: rightSpacer,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0.0)
        container.addConstraint(equalWidthSpacerConstraint)

        if let firstItem = items.first {
            let leadingConstraint = NSLayoutConstraint(
                item: firstItem.view,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: leftSpacer,
                attribute: .Right,
                multiplier: 1.0,
                constant: 0.0)
            container.addConstraint(leadingConstraint)
        }
        if let lastItem = items.last {
            let trailingConstraint = NSLayoutConstraint(
                item: lastItem.view,
                attribute: .Right,
                relatedBy: .Equal,
                toItem: rightSpacer,
                attribute: .Left,
                multiplier: 1.0,
                constant: 0.0)
            container.addConstraint(trailingConstraint)
        }
    }

    var prevItem: LayoutComponent? = nil
    for item in items {
        // Flex settings.
        if let flex = item.flex {
            if let _minFlexItem = minFlexItem, _minFlex = minFlex {
                if item !== _minFlexItem {
                    let sizeRatioConstraint = NSLayoutConstraint(
                        item: item.view,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: _minFlexItem.view,
                        attribute: .Width,
                        multiplier: CGFloat(flex/_minFlex),
                        constant:0.0)
                    container.addConstraint(sizeRatioConstraint)
                }
            }
        }
        // Set mergin to the previous component.
        if let _prevItem = prevItem {
            let leftMargin:CGFloat = (_prevItem.marginRight ?? layout.defaultMargins.right) + (item.marginLeft ?? layout.defaultMargins.left)
            let leadingConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: _prevItem.view,
                attribute: .Right,
                multiplier: 1.0,
                constant: leftMargin)
            container.addConstraint(leadingConstraint)
        }

        // Align の設定.
        // Start: Left aligned, Center: Center aligned, End: Right aligned.
        let align = item.align ?? layout.align
        if align == .Start {
            let topMargin:CGFloat = item.marginTop ?? layout.defaultMargins.top
            let topConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: container,
                attribute: .Top,
                multiplier: 1.0,
                constant: topMargin)
            container.addConstraint(topConstraint)
        }
        else if align == .End {
            let bottomMargin:CGFloat = item.marginBottom ?? layout.defaultMargins.bottom
            let bottomConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: container,
                attribute: .Bottom,
                multiplier: 1.0,
                constant: -bottomMargin)
            container.addConstraint(bottomConstraint)
        }
        else if align == .Center {
            let centerConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .CenterY,
                relatedBy: .Equal,
                toItem: container,
                attribute: .CenterY,
                multiplier: 1.0,
                constant: 0.0)
            container.addConstraint(centerConstraint)
        }
        else if align == .Stretch {
            if let heightConstraint = getHeightConstraintOfView(item.view) {
                //
                // if height constraint is set, align centered.
                //
                let centerConstraint = NSLayoutConstraint(
                    item: item.view,
                    attribute: .CenterY,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .CenterY,
                    multiplier: 1.0,
                    constant: 0.0)
                container.addConstraint(centerConstraint)
            }
            else {
                //
                // if width constraint is not set, expand width to fit parent view.
                //
                let topMargin:CGFloat = item.marginTop ?? layout.defaultMargins.top
                let topConstraint = NSLayoutConstraint(
                    item: item.view,
                    attribute: .Top,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .Top,
                    multiplier: 1.0,
                    constant: topMargin)
                
                let bottomMargin:CGFloat = item.marginBottom ?? layout.defaultMargins.bottom
                let bottomConstraint = NSLayoutConstraint(
                    item: item.view,
                    attribute: .Bottom,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .Bottom,
                    multiplier: 1.0,
                    constant: -bottomMargin)
                
                container.addConstraints([topConstraint, bottomConstraint])
            }
        }
        prevItem = item
    }
}

private func addItemsToContainerWithRelative(container: UIView, layout: Relative, items: [LayoutComponent]) {
    for item in items {
        let view = item.view
        view.setTranslatesAutoresizingMaskIntoConstraints(false)

        container.addSubview(item.view)
        if let halign = item.halign {
            let view = item.view

            let hconstraint: NSLayoutConstraint
            switch halign {
            case .Left:
                let leftMargin:CGFloat = item.marginLeft ?? layout.defaultMargins.left
                hconstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .Left,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .Left,
                    multiplier: 1.0,
                    constant: leftMargin)
            case .Right:
                let rightMargin:CGFloat = item.marginRight ?? layout.defaultMargins.right
                hconstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .Right,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .Right,
                    multiplier: 1.0,
                    constant: -rightMargin)
            case .Center:
                hconstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .CenterX,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .CenterX,
                    multiplier: 1.0,
                    constant: 0)
            }
            container.addConstraint(hconstraint)
        }
        else {
            //
            // if halign is not set.
            //
            if let widthConstraint = getWidthConstraintOfView(item.view) {
                // align centered is with constraint is set.
                let centerXConstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .CenterX,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .CenterX,
                    multiplier: 1.0,
                    constant: 0)
                container.addConstraint(centerXConstraint)
            }
            else {
                // expand the width to the container width if width constraint is not set.
                let leftMargin:CGFloat = item.marginLeft ?? layout.defaultMargins.left
                let leftConstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .Left,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .Left,
                    multiplier: 1.0,
                    constant: leftMargin)
                
                let rightMargin:CGFloat = item.marginRight ?? layout.defaultMargins.right
                let rightConstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .Right,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .Right,
                    multiplier: 1.0,
                    constant: -rightMargin)
                container.addConstraints([leftConstraint, rightConstraint])
            }
        }

        if let valign = item.valign {
            let vconstraint: NSLayoutConstraint
            switch valign {
            case .Top:
                let topMargin:CGFloat = item.marginTop ?? layout.defaultMargins.top
                vconstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .Top,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .Top,
                    multiplier: 1.0,
                    constant: topMargin)
            case .Bottom:
                let bottomMargin:CGFloat = item.marginBottom ?? layout.defaultMargins.bottom
                vconstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .Bottom,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .Bottom,
                    multiplier: 1.0,
                    constant: -bottomMargin)
            case .Center:
                vconstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .CenterY,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .CenterY,
                    multiplier: 1.0,
                    constant: 0)
            }
            container.addConstraint(vconstraint)
        }
        else {
            //
            // if valign is not set.
            //
            if let heightConstraint = getHeightConstraintOfView(item.view) {
                // align centered is with constraint is set.
                let centerYConstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .CenterY,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .CenterY,
                    multiplier: 1.0,
                    constant: 0)
                container.addConstraint(centerYConstraint)
            }
            else {
                // expand the width to the container width if width constraint is not set.
                let topMargin:CGFloat = item.marginTop ?? layout.defaultMargins.top
                let topConstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .Top,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .Top,
                    multiplier: 1.0,
                    constant: topMargin)
                
                let bottomMargin:CGFloat = item.marginBottom ?? layout.defaultMargins.bottom
                let bottomConstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .Bottom,
                    relatedBy: .Equal,
                    toItem: container,
                    attribute: .Bottom,
                    multiplier: 1.0,
                    constant: -bottomMargin)
                container.addConstraints([topConstraint, bottomConstraint])
            }
        }
    }
}

private func addItemsToContainerWithFit(container: UIView, layout: Fit, items: [LayoutComponent]) {
    for item in items {
        container.addSubview(item.view)
        item.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        let leftMargin:CGFloat = item.marginLeft ?? layout.defaultMargins.left
        let leftConstraint = NSLayoutConstraint(
            item: item.view,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: container,
            attribute: .Left,
            multiplier: 1.0,
            constant: leftMargin)

        let rightMargin:CGFloat = item.marginRight ?? layout.defaultMargins.right
        let rightConstraint = NSLayoutConstraint(
            item: item.view,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: container,
            attribute: .Right,
            multiplier: 1.0,
            constant: -rightMargin)

        let topMargin:CGFloat = item.marginTop ?? layout.defaultMargins.top
        let topConstraint = NSLayoutConstraint(
            item: item.view,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: container,
            attribute: .Top,
            multiplier: 1.0,
            constant: topMargin)

        let bottomMargin:CGFloat = item.marginBottom ?? layout.defaultMargins.bottom
        let bottomConstraint = NSLayoutConstraint(
            item: item.view,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: container,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: -bottomMargin)
        container.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}

private func createTopSpacer(container: UIView) -> UIView {
    let topSpacer = UIView()
    topSpacer.userInteractionEnabled = false
    container.addSubview(topSpacer)
    topSpacer.setTranslatesAutoresizingMaskIntoConstraints(false)

    let topConstraint = NSLayoutConstraint(
        item: topSpacer,
        attribute: .Top,
        relatedBy: .Equal,
        toItem: container,
        attribute: .Top,
        multiplier: 1.0,
        constant: 0.0)
    let leftConstraint = NSLayoutConstraint(
        item: topSpacer,
        attribute: .Left,
        relatedBy: .Equal,
        toItem: container,
        attribute: .Left,
        multiplier: 1.0,
        constant: 0.0)
    let rightConstraint = NSLayoutConstraint(
        item: topSpacer,
        attribute: .Right,
        relatedBy: .Equal,
        toItem: container,
        attribute: .Right,
        multiplier: 1.0,
        constant: 0.0)

    container.addConstraints([topConstraint, leftConstraint, rightConstraint])
    return topSpacer
}

private func createBottomSpacer(container: UIView) -> UIView {
    let bottomSpacer = UIView()
    bottomSpacer.userInteractionEnabled = false
    container.addSubview(bottomSpacer)
    bottomSpacer.setTranslatesAutoresizingMaskIntoConstraints(false)

    let bottomConstraint = NSLayoutConstraint(
        item: bottomSpacer,
        attribute: .Bottom,
        relatedBy: .Equal,
        toItem: container,
        attribute: .Bottom,
        multiplier: 1.0,
        constant: 0.0)
    let leftConstraint = NSLayoutConstraint(
        item: bottomSpacer,
        attribute: .Left,
        relatedBy: .Equal,
        toItem: container,
        attribute: .Left,
        multiplier: 1.0,
        constant: 0.0)
    let rightConstraint = NSLayoutConstraint(
        item: bottomSpacer,
        attribute: .Right,
        relatedBy: .Equal,
        toItem: container,
        attribute: .Right,
        multiplier: 1.0,
        constant: 0.0)

    container.addConstraints([bottomConstraint, leftConstraint, rightConstraint])
    return bottomSpacer
}

private func createLeftSpacer(container: UIView) -> UIView {
    let leftSpacer = UIView()
    leftSpacer.userInteractionEnabled = false
    container.addSubview(leftSpacer)
    leftSpacer.setTranslatesAutoresizingMaskIntoConstraints(false)

    let leftConstraint = NSLayoutConstraint(
        item: leftSpacer,
        attribute: .Left,
        relatedBy: .Equal,
        toItem: container,
        attribute: .Left,
        multiplier: 1.0,
        constant: 0.0)
    let topConstraint = NSLayoutConstraint(
        item: leftSpacer,
        attribute: .Top,
        relatedBy: .Equal,
        toItem: container,
        attribute: .Top,
        multiplier: 1.0,
        constant: 0.0)
    let bottomConstraint = NSLayoutConstraint(
        item: leftSpacer,
        attribute: .Bottom,
        relatedBy: .Equal,
        toItem: container,
        attribute: .Bottom,
        multiplier: 1.0,
        constant: 0.0)

    container.addConstraints([leftConstraint, topConstraint, bottomConstraint])
    return leftSpacer
}

private func createRightSpacer(container: UIView) -> UIView {
    let rightSpacer = UIView()
    rightSpacer.userInteractionEnabled = false
    container.addSubview(rightSpacer)
    rightSpacer.setTranslatesAutoresizingMaskIntoConstraints(false)

    let rightConstraint = NSLayoutConstraint(
        item: rightSpacer,
        attribute: .Right,
        relatedBy: .Equal,
        toItem: container,
        attribute: .Right,
        multiplier: 1.0,
        constant: 0.0)
    let topConstraint = NSLayoutConstraint(
        item: rightSpacer,
        attribute: .Top,
        relatedBy: .Equal,
        toItem: container,
        attribute: .Top,
        multiplier: 1.0,
        constant: 0.0)
    let bottomConstraint = NSLayoutConstraint(
        item: rightSpacer,
        attribute: .Bottom,
        relatedBy: .Equal,
        toItem: container,
        attribute: .Bottom,
        multiplier: 1.0,
        constant: 0.0)

    container.addConstraints([rightConstraint, topConstraint, bottomConstraint])
    return rightSpacer
}

private func getWidthConstraintOfView(view: UIView) -> NSLayoutConstraint? {
    for obj in view.constraints() {
        if let constraint = obj as? NSLayoutConstraint {
            if constraint.firstItem === view && constraint.firstAttribute == .Width {
                return constraint
            }
        }
    }
    return nil
}

private func getHeightConstraintOfView(view: UIView) -> NSLayoutConstraint? {
    for obj in view.constraints() {
        if let constraint = obj as? NSLayoutConstraint {
            if constraint.firstItem === view && constraint.firstAttribute == .Height {
                return constraint
            }
        }
    }
    return nil
}

public extension UIView {
    public func applyLayout(layout: Layout, items: [LayoutComponent]) -> LayoutComponent {
        return $(self, layout: layout, items: items)
    }

    public func applyLayout(layout: Layout, item: LayoutComponent) -> LayoutComponent {
        return $(self, layout: layout, item: item)
    }

    public func setSizeConstraint(#width: CGFloat?, height: CGFloat?) -> (NSLayoutConstraint?, NSLayoutConstraint?) {
        var widthConstraint: NSLayoutConstraint? = nil
        var heightConstraint: NSLayoutConstraint? = nil
        if let _width = width  {
            widthConstraint = NSLayoutConstraint(
                item: self,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Width,
                multiplier: 1.0,
                constant: _width)
            self.addConstraint(widthConstraint!)
        }
        if let _height = height {
            heightConstraint = NSLayoutConstraint(
                item: self,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Height,
                multiplier: 1.0,
                constant: _height)
            self.addConstraint(heightConstraint!)
        }

        return (widthConstraint, heightConstraint)
    }
}
