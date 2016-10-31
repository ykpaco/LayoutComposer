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
    case stretch // Default
    case start
    case center
    case end
}

public enum BoxLayoutPack {
    case start
    case center
    case end
    case fit
}

open class Layout {
    let defaultMargins: UIEdgeInsets

    public init(defaultMargins: UIEdgeInsets) {
        self.defaultMargins = defaultMargins
    }
}

open class VBox: Layout {
    let align: BoxLayoutAlign
    let pack: BoxLayoutPack

    public init(align: BoxLayoutAlign = .stretch, pack: BoxLayoutPack = .start, defaultMargins: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)) {
        self.align = align
        self.pack = pack
        super.init(defaultMargins: UIEdgeInsetsMake(defaultMargins.0, defaultMargins.1, defaultMargins.2, defaultMargins.3))
    }
}

open class HBox: Layout {
    let align: BoxLayoutAlign
    let pack: BoxLayoutPack

    public init(align: BoxLayoutAlign = .stretch, pack: BoxLayoutPack = .start, defaultMargins: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)) {
        self.align = align
        self.pack = pack
        super.init(defaultMargins: UIEdgeInsetsMake(defaultMargins.0, defaultMargins.1, defaultMargins.2, defaultMargins.3))
    }
}

public enum RelativeLayoutVAlign {
    case top
    case center
    case bottom
}

public enum RelativeLayoutHAlign {
    case left
    case center
    case right
}

open class Relative: Layout {
    public init(defaultMargins: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)) {
        super.init(defaultMargins: UIEdgeInsetsMake(defaultMargins.0, defaultMargins.1, defaultMargins.2, defaultMargins.3))
    }
}

open class Fit: Layout {
    public init(defaultMargins: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)) {
        super.init(defaultMargins: UIEdgeInsetsMake(defaultMargins.0, defaultMargins.1, defaultMargins.2, defaultMargins.3))
    }
}

open class LayoutComponent {
    open let view: UIView
    fileprivate var width: CGFloat?
    fileprivate var height: CGFloat?
    open let flex: CGFloat?
    open let layout: Layout?
    open let marginTop: CGFloat?
    open let marginLeft: CGFloat?
    open let marginBottom: CGFloat?
    open let marginRight: CGFloat?
    open let align: BoxLayoutAlign?
    open let halign: RelativeLayoutHAlign?
    open let valign: RelativeLayoutVAlign?
    var widthConstraintInternal: NSLayoutConstraint?
    var heightConstraintInternal: NSLayoutConstraint?
    
    open var widthConstraint: NSLayoutConstraint? {
        return widthConstraintInternal
    }
    
    open var heightConstraint: NSLayoutConstraint? {
        return heightConstraintInternal
    }

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
            self.widthConstraintInternal = widthConstraint
            self.heightConstraintInternal = heightConstraint
    }

    open func updateWidth(_ width: CGFloat) {
        if let constraint = widthConstraintInternal {
            view.removeConstraint(constraint)
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .width,
            multiplier: 1.0,
            constant: width)
        view.addConstraint(constraint)
        widthConstraintInternal = constraint
        self.width = width
    }

    open func updateHeight(_ height: CGFloat) {
        if let constraint = heightConstraintInternal {
            view.removeConstraint(constraint)
        }
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1.0,
            constant: height)
        view.addConstraint(constraint)
        heightConstraintInternal = constraint
        self.height = height
    }
}

public func $(_ view: UIView?,
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    flex: CGFloat? = nil,
    align: BoxLayoutAlign? = nil,
    halign: RelativeLayoutHAlign? = nil,
    valign: RelativeLayoutVAlign? = nil,
    margins: (CGFloat, CGFloat, CGFloat, CGFloat)? = nil,
    marginTop: CGFloat? = nil,
    marginLeft: CGFloat? = nil,
    marginBottom: CGFloat? = nil,
    marginRight: CGFloat? = nil,
    layout: Layout? = nil,
    item: LayoutComponent) -> LayoutComponent {

    return $(view,
            width: width,
            height: height,
            flex: flex,
            align: align,
            halign: halign,
            valign: valign,
            margins: margins,
            marginTop: marginTop,
            marginLeft: marginLeft,
            marginBottom: marginBottom,
            marginRight: marginRight,
            layout: layout,
            items: [item])
}

// Create a new layouted view or apply layout to view.
public func $(_ view: UIView?,
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    flex: CGFloat? = nil,
    align: BoxLayoutAlign? = nil,
    halign: RelativeLayoutHAlign? = nil,
    valign: RelativeLayoutVAlign? = nil,
    margins: (CGFloat, CGFloat, CGFloat, CGFloat)? = nil,
    marginTop: CGFloat? = nil,
    marginLeft: CGFloat? = nil,
    marginBottom: CGFloat? = nil,
    marginRight: CGFloat? = nil,
    layout: Layout? = nil,
    items: [LayoutComponent]? = nil) -> LayoutComponent {

        let container = view ?? UIView()
        let (widthConstraint, heightConstraint) = container.setSizeConstraint(width:width, height: height)

        if let _layout = layout, let _items = items {
            switch _layout {
            case let vbox as VBox:
                 addItemsToContainerWithVBox(container, layout: vbox, items: _items)
            case let hbox as HBox:
                addItemsToContainerWithHBox(container, layout: hbox, items: _items)
            case let relative as Relative:
                addItemsToContainerWithRelative(container, layout: relative, items: _items)
            case let fit as Fit:
                addItemsToContainerWithFit(container, layout: fit, items: _items)
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

private func addItemsToContainerWithVBox(_ container: UIView, layout: VBox, items: [LayoutComponent]) {
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
        item.view.translatesAutoresizingMaskIntoConstraints = false
    }

    if minFlexItem != nil && minFlex != nil || layout.pack == .fit {
        // if pack attribute is set to Fit, or the item's flex is set,
        // the container height is adjusted to contain the items.
        if let firstItem = items.first {
            let topMargin:CGFloat = firstItem.marginTop ?? layout.defaultMargins.top
            let leadingConstraint = NSLayoutConstraint(
                item: firstItem.view,
                attribute: .top,
                relatedBy: .equal,
                toItem: container,
                attribute: .top,
                multiplier: 1.0,
                constant: topMargin)
            container.addConstraint(leadingConstraint)
        }
        if let lastItem = items.last {
            let bottomMargin:CGFloat = lastItem.marginBottom ?? layout.defaultMargins.bottom
            let trailingConstraint = NSLayoutConstraint(
                item: lastItem.view,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: container,
                attribute: .bottom,
                multiplier: 1.0,
                constant: -bottomMargin)
            container.addConstraint(trailingConstraint)
        }
    }
    else if layout.pack == .start {
        // Top aligned.
        if let firstItem = items.first {
            let topMargin:CGFloat = firstItem.marginTop ?? layout.defaultMargins.top
            let leadingConstraint = NSLayoutConstraint(
                item: firstItem.view,
                attribute: .top,
                relatedBy: .equal,
                toItem: container,
                attribute: .top,
                multiplier: 1.0,
                constant: topMargin)
            container.addConstraint(leadingConstraint)
        }
    }
    else if layout.pack == .end {
        // Bottom aligned.
        if let lastItem = items.last {
            let bottomMargin:CGFloat = lastItem.marginBottom ?? layout.defaultMargins.bottom
            let trailingConstraint = NSLayoutConstraint(
                item: lastItem.view,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: container,
                attribute: .bottom,
                multiplier: 1.0,
                constant: -bottomMargin)
            container.addConstraint(trailingConstraint)
        }
    }
    else if layout.pack == .center {
        // insert spacers of the same height to add mergins to above and below the items.
        let topSpacer = createTopSpacer(container)
        let bottomSpacer = createBottomSpacer(container)
        let equalHeightSpacerConstraint = NSLayoutConstraint(
            item: bottomSpacer,
            attribute: .height,
            relatedBy: .equal,
            toItem: topSpacer,
            attribute: .height,
            multiplier: 1.0,
            constant: 0.0)
        container.addConstraint(equalHeightSpacerConstraint)

        if let firstItem = items.first {
            let leadingConstraint = NSLayoutConstraint(
                item: firstItem.view,
                attribute: .top,
                relatedBy: .equal,
                toItem: topSpacer,
                attribute: .bottom,
                multiplier: 1.0,
                constant: 0.0)
            container.addConstraint(leadingConstraint)
        }
        if let lastItem = items.last {
            let trailingConstraint = NSLayoutConstraint(
                item: lastItem.view,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: bottomSpacer,
                attribute: .top,
                multiplier: 1.0,
                constant: 0.0)
            container.addConstraint(trailingConstraint)
        }
    }

    var prevItem: LayoutComponent? = nil
    for item in items {
        // Flex settings.
        if let flex = item.flex {
            if let _minFlexItem = minFlexItem, let _minFlex = minFlex {
                if item !== _minFlexItem {
                    let sizeRatioConstraint = NSLayoutConstraint(
                        item: item.view,
                        attribute: .height,
                        relatedBy: .equal,
                        toItem: _minFlexItem.view,
                        attribute: .height,
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
                attribute: .top,
                relatedBy: .equal,
                toItem: _prevItem.view,
                attribute: .bottom,
                multiplier: 1.0,
                constant: topMargin)
            container.addConstraint(leadingConstraint)
        }

        // Alignent.
        // Start: Left aligned, Center: Center aligned, End: Right aligned.
        let align = item.align ?? layout.align
        if align == .start {
            let leftMargin:CGFloat = item.marginLeft ?? layout.defaultMargins.left
            let leftConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .left,
                relatedBy: .equal,
                toItem: container,
                attribute: .left,
                multiplier: 1.0,
                constant: leftMargin)
            container.addConstraint(leftConstraint)
        }
        else if align == .end {
            let rightMargin:CGFloat = item.marginRight ?? layout.defaultMargins.right
            let rightConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .right,
                relatedBy: .equal,
                toItem: container,
                attribute: .right,
                multiplier: 1.0,
                constant: -rightMargin)
            container.addConstraint(rightConstraint)
        }
        else if align == .center {
            let centerConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: container,
                attribute: .centerX,
                multiplier: 1.0,
                constant: 0.0)
            container.addConstraint(centerConstraint)
        }
        else if align == .stretch {
            if let _ = getWidthConstraintOfView(item.view) {
                //
                // if width constraint is set, align centered.
                //
                let centerConstraint = NSLayoutConstraint(
                    item: item.view,
                    attribute: .centerX,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .centerX,
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
                    attribute: .left,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .left,
                    multiplier: 1.0,
                    constant: leftMargin)
                
                let rightMargin:CGFloat = item.marginRight ?? layout.defaultMargins.right
                let rightConstraint = NSLayoutConstraint(
                    item: item.view,
                    attribute: .right,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .right,
                    multiplier: 1.0,
                    constant: -rightMargin)
                
                container.addConstraints([leftConstraint, rightConstraint])
            }
        }
        prevItem = item
    }
}

private func addItemsToContainerWithHBox(_ container: UIView, layout: HBox, items: [LayoutComponent]) {
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
        item.view.translatesAutoresizingMaskIntoConstraints = false
    }

    if minFlexItem != nil && minFlex != nil || layout.pack == .fit {
        // if pack attribute is set to Fit, or the item's flex is set,
        // the container width is adjusted to contain the items.
        if let firstItem = items.first {
            let leftMargin:CGFloat = firstItem.marginLeft ?? layout.defaultMargins.left
            let leadingConstraint = NSLayoutConstraint(
                item: firstItem.view,
                attribute: .left,
                relatedBy: .equal,
                toItem: container,
                attribute: .left,
                multiplier: 1.0,
                constant: leftMargin)
            container.addConstraint(leadingConstraint)
        }
        if let lastItem = items.last {
            let rightMargin:CGFloat = lastItem.marginRight ?? layout.defaultMargins.right
            let trailingConstraint = NSLayoutConstraint(
                item: lastItem.view,
                attribute: .right,
                relatedBy: .equal,
                toItem: container,
                attribute: .right,
                multiplier: 1.0,
                constant: -rightMargin)
            container.addConstraint(trailingConstraint)
        }
    }
    else if layout.pack == .start {
        // Left aligned.
        if let firstItem = items.first {
            let leftMargin:CGFloat = firstItem.marginLeft ?? layout.defaultMargins.left
            let leadingConstraint = NSLayoutConstraint(
                item: firstItem.view,
                attribute: .left,
                relatedBy: .equal,
                toItem: container,
                attribute: .left,
                multiplier: 1.0,
                constant: leftMargin)
            container.addConstraint(leadingConstraint)
        }
    }
    else if layout.pack == .end {
        // Right aligned.
        if let lastItem = items.last {
            let rightMargin:CGFloat = lastItem.marginRight ?? layout.defaultMargins.right
            let trailingConstraint = NSLayoutConstraint(
                item: lastItem.view,
                attribute: .right,
                relatedBy: .equal,
                toItem: container,
                attribute: .right,
                multiplier: 1.0,
                constant: -rightMargin)
            container.addConstraint(trailingConstraint)
        }
    }
    else if layout.pack == .center {
        // insert spacers of the same width to add mergins to left and right to the items.
        let leftSpacer = createLeftSpacer(container)
        let rightSpacer = createRightSpacer(container)
        let equalWidthSpacerConstraint = NSLayoutConstraint(
            item: leftSpacer,
            attribute: .width,
            relatedBy: .equal,
            toItem: rightSpacer,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0)
        container.addConstraint(equalWidthSpacerConstraint)

        if let firstItem = items.first {
            let leadingConstraint = NSLayoutConstraint(
                item: firstItem.view,
                attribute: .left,
                relatedBy: .equal,
                toItem: leftSpacer,
                attribute: .right,
                multiplier: 1.0,
                constant: 0.0)
            container.addConstraint(leadingConstraint)
        }
        if let lastItem = items.last {
            let trailingConstraint = NSLayoutConstraint(
                item: lastItem.view,
                attribute: .right,
                relatedBy: .equal,
                toItem: rightSpacer,
                attribute: .left,
                multiplier: 1.0,
                constant: 0.0)
            container.addConstraint(trailingConstraint)
        }
    }

    var prevItem: LayoutComponent? = nil
    for item in items {
        // Flex settings.
        if let flex = item.flex {
            if let _minFlexItem = minFlexItem, let _minFlex = minFlex {
                if item !== _minFlexItem {
                    let sizeRatioConstraint = NSLayoutConstraint(
                        item: item.view,
                        attribute: .width,
                        relatedBy: .equal,
                        toItem: _minFlexItem.view,
                        attribute: .width,
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
                attribute: .left,
                relatedBy: .equal,
                toItem: _prevItem.view,
                attribute: .right,
                multiplier: 1.0,
                constant: leftMargin)
            container.addConstraint(leadingConstraint)
        }

        // Align の設定.
        // Start: Left aligned, Center: Center aligned, End: Right aligned.
        let align = item.align ?? layout.align
        if align == .start {
            let topMargin:CGFloat = item.marginTop ?? layout.defaultMargins.top
            let topConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .top,
                relatedBy: .equal,
                toItem: container,
                attribute: .top,
                multiplier: 1.0,
                constant: topMargin)
            container.addConstraint(topConstraint)
        }
        else if align == .end {
            let bottomMargin:CGFloat = item.marginBottom ?? layout.defaultMargins.bottom
            let bottomConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: container,
                attribute: .bottom,
                multiplier: 1.0,
                constant: -bottomMargin)
            container.addConstraint(bottomConstraint)
        }
        else if align == .center {
            let centerConstraint = NSLayoutConstraint(
                item: item.view,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: container,
                attribute: .centerY,
                multiplier: 1.0,
                constant: 0.0)
            container.addConstraint(centerConstraint)
        }
        else if align == .stretch {
            if let _ = getHeightConstraintOfView(item.view) {
                //
                // if height constraint is set, align centered.
                //
                let centerConstraint = NSLayoutConstraint(
                    item: item.view,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .centerY,
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
                    attribute: .top,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .top,
                    multiplier: 1.0,
                    constant: topMargin)
                
                let bottomMargin:CGFloat = item.marginBottom ?? layout.defaultMargins.bottom
                let bottomConstraint = NSLayoutConstraint(
                    item: item.view,
                    attribute: .bottom,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .bottom,
                    multiplier: 1.0,
                    constant: -bottomMargin)
                
                container.addConstraints([topConstraint, bottomConstraint])
            }
        }
        prevItem = item
    }
}

private func addItemsToContainerWithRelative(_ container: UIView, layout: Relative, items: [LayoutComponent]) {
    for item in items {
        let view = item.view
        view.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(item.view)
        if let halign = item.halign {
            let view = item.view

            let hconstraint: NSLayoutConstraint
            switch halign {
            case .left:
                let leftMargin:CGFloat = item.marginLeft ?? layout.defaultMargins.left
                hconstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .left,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .left,
                    multiplier: 1.0,
                    constant: leftMargin)
            case .right:
                let rightMargin:CGFloat = item.marginRight ?? layout.defaultMargins.right
                hconstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .right,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .right,
                    multiplier: 1.0,
                    constant: -rightMargin)
            case .center:
                hconstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .centerX,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .centerX,
                    multiplier: 1.0,
                    constant: 0)
            }
            container.addConstraint(hconstraint)
        }
        else {
            //
            // if halign is not set.
            //
            if let _ = getWidthConstraintOfView(item.view) {
                // align centered is with constraint is set.
                let centerXConstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .centerX,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .centerX,
                    multiplier: 1.0,
                    constant: 0)
                container.addConstraint(centerXConstraint)
            }
            else {
                // expand the width to the container width if width constraint is not set.
                let leftMargin:CGFloat = item.marginLeft ?? layout.defaultMargins.left
                let leftConstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .left,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .left,
                    multiplier: 1.0,
                    constant: leftMargin)
                
                let rightMargin:CGFloat = item.marginRight ?? layout.defaultMargins.right
                let rightConstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .right,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .right,
                    multiplier: 1.0,
                    constant: -rightMargin)
                container.addConstraints([leftConstraint, rightConstraint])
            }
        }

        if let valign = item.valign {
            let vconstraint: NSLayoutConstraint
            switch valign {
            case .top:
                let topMargin:CGFloat = item.marginTop ?? layout.defaultMargins.top
                vconstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .top,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .top,
                    multiplier: 1.0,
                    constant: topMargin)
            case .bottom:
                let bottomMargin:CGFloat = item.marginBottom ?? layout.defaultMargins.bottom
                vconstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .bottom,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .bottom,
                    multiplier: 1.0,
                    constant: -bottomMargin)
            case .center:
                vconstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .centerY,
                    multiplier: 1.0,
                    constant: 0)
            }
            container.addConstraint(vconstraint)
        }
        else {
            //
            // if valign is not set.
            //
            if let _ = getHeightConstraintOfView(item.view) {
                // align centered is with constraint is set.
                let centerYConstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .centerY,
                    multiplier: 1.0,
                    constant: 0)
                container.addConstraint(centerYConstraint)
            }
            else {
                // expand the width to the container width if width constraint is not set.
                let topMargin:CGFloat = item.marginTop ?? layout.defaultMargins.top
                let topConstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .top,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .top,
                    multiplier: 1.0,
                    constant: topMargin)
                
                let bottomMargin:CGFloat = item.marginBottom ?? layout.defaultMargins.bottom
                let bottomConstraint = NSLayoutConstraint(
                    item: view,
                    attribute: .bottom,
                    relatedBy: .equal,
                    toItem: container,
                    attribute: .bottom,
                    multiplier: 1.0,
                    constant: -bottomMargin)
                container.addConstraints([topConstraint, bottomConstraint])
            }
        }
    }
}

private func addItemsToContainerWithFit(_ container: UIView, layout: Fit, items: [LayoutComponent]) {
    for item in items {
        container.addSubview(item.view)
        item.view.translatesAutoresizingMaskIntoConstraints = false
        let leftMargin:CGFloat = item.marginLeft ?? layout.defaultMargins.left
        let leftConstraint = NSLayoutConstraint(
            item: item.view,
            attribute: .left,
            relatedBy: .equal,
            toItem: container,
            attribute: .left,
            multiplier: 1.0,
            constant: leftMargin)

        let rightMargin:CGFloat = item.marginRight ?? layout.defaultMargins.right
        let rightConstraint = NSLayoutConstraint(
            item: item.view,
            attribute: .right,
            relatedBy: .equal,
            toItem: container,
            attribute: .right,
            multiplier: 1.0,
            constant: -rightMargin)

        let topMargin:CGFloat = item.marginTop ?? layout.defaultMargins.top
        let topConstraint = NSLayoutConstraint(
            item: item.view,
            attribute: .top,
            relatedBy: .equal,
            toItem: container,
            attribute: .top,
            multiplier: 1.0,
            constant: topMargin)

        let bottomMargin:CGFloat = item.marginBottom ?? layout.defaultMargins.bottom
        let bottomConstraint = NSLayoutConstraint(
            item: item.view,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: container,
            attribute: .bottom,
            multiplier: 1.0,
            constant: -bottomMargin)
        container.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}

private func createTopSpacer(_ container: UIView) -> UIView {
    let topSpacer = UIView()
    topSpacer.isUserInteractionEnabled = false
    container.addSubview(topSpacer)
    topSpacer.translatesAutoresizingMaskIntoConstraints = false

    let topConstraint = NSLayoutConstraint(
        item: topSpacer,
        attribute: .top,
        relatedBy: .equal,
        toItem: container,
        attribute: .top,
        multiplier: 1.0,
        constant: 0.0)
    let leftConstraint = NSLayoutConstraint(
        item: topSpacer,
        attribute: .left,
        relatedBy: .equal,
        toItem: container,
        attribute: .left,
        multiplier: 1.0,
        constant: 0.0)
    let rightConstraint = NSLayoutConstraint(
        item: topSpacer,
        attribute: .right,
        relatedBy: .equal,
        toItem: container,
        attribute: .right,
        multiplier: 1.0,
        constant: 0.0)

    container.addConstraints([topConstraint, leftConstraint, rightConstraint])
    return topSpacer
}

private func createBottomSpacer(_ container: UIView) -> UIView {
    let bottomSpacer = UIView()
    bottomSpacer.isUserInteractionEnabled = false
    container.addSubview(bottomSpacer)
    bottomSpacer.translatesAutoresizingMaskIntoConstraints = false

    let bottomConstraint = NSLayoutConstraint(
        item: bottomSpacer,
        attribute: .bottom,
        relatedBy: .equal,
        toItem: container,
        attribute: .bottom,
        multiplier: 1.0,
        constant: 0.0)
    let leftConstraint = NSLayoutConstraint(
        item: bottomSpacer,
        attribute: .left,
        relatedBy: .equal,
        toItem: container,
        attribute: .left,
        multiplier: 1.0,
        constant: 0.0)
    let rightConstraint = NSLayoutConstraint(
        item: bottomSpacer,
        attribute: .right,
        relatedBy: .equal,
        toItem: container,
        attribute: .right,
        multiplier: 1.0,
        constant: 0.0)

    container.addConstraints([bottomConstraint, leftConstraint, rightConstraint])
    return bottomSpacer
}

private func createLeftSpacer(_ container: UIView) -> UIView {
    let leftSpacer = UIView()
    leftSpacer.isUserInteractionEnabled = false
    container.addSubview(leftSpacer)
    leftSpacer.translatesAutoresizingMaskIntoConstraints = false

    let leftConstraint = NSLayoutConstraint(
        item: leftSpacer,
        attribute: .left,
        relatedBy: .equal,
        toItem: container,
        attribute: .left,
        multiplier: 1.0,
        constant: 0.0)
    let topConstraint = NSLayoutConstraint(
        item: leftSpacer,
        attribute: .top,
        relatedBy: .equal,
        toItem: container,
        attribute: .top,
        multiplier: 1.0,
        constant: 0.0)
    let bottomConstraint = NSLayoutConstraint(
        item: leftSpacer,
        attribute: .bottom,
        relatedBy: .equal,
        toItem: container,
        attribute: .bottom,
        multiplier: 1.0,
        constant: 0.0)

    container.addConstraints([leftConstraint, topConstraint, bottomConstraint])
    return leftSpacer
}

private func createRightSpacer(_ container: UIView) -> UIView {
    let rightSpacer = UIView()
    rightSpacer.isUserInteractionEnabled = false
    container.addSubview(rightSpacer)
    rightSpacer.translatesAutoresizingMaskIntoConstraints = false

    let rightConstraint = NSLayoutConstraint(
        item: rightSpacer,
        attribute: .right,
        relatedBy: .equal,
        toItem: container,
        attribute: .right,
        multiplier: 1.0,
        constant: 0.0)
    let topConstraint = NSLayoutConstraint(
        item: rightSpacer,
        attribute: .top,
        relatedBy: .equal,
        toItem: container,
        attribute: .top,
        multiplier: 1.0,
        constant: 0.0)
    let bottomConstraint = NSLayoutConstraint(
        item: rightSpacer,
        attribute: .bottom,
        relatedBy: .equal,
        toItem: container,
        attribute: .bottom,
        multiplier: 1.0,
        constant: 0.0)

    container.addConstraints([rightConstraint, topConstraint, bottomConstraint])
    return rightSpacer
}

private func getWidthConstraintOfView(_ view: UIView) -> NSLayoutConstraint? {
    for constraint in view.constraints {
        if constraint.firstItem === view && constraint.firstAttribute == .width {
            return constraint
        }
    }
    return nil
}

private func getHeightConstraintOfView(_ view: UIView) -> NSLayoutConstraint? {
    for constraint in view.constraints {
        if constraint.firstItem === view && constraint.firstAttribute == .height {
            return constraint
        }
    }
    return nil
}

public extension UIView {
    @discardableResult
    public func applyLayout(_ layout: Layout, items: [LayoutComponent]) -> LayoutComponent {
        return $(self, layout: layout, items: items)
    }

    @discardableResult
    public func applyLayout(_ layout: Layout, item: LayoutComponent) -> LayoutComponent {
        return $(self, layout: layout, item: item)
    }

    @discardableResult
    public func setSizeConstraint(width: CGFloat?, height: CGFloat?) -> (NSLayoutConstraint?, NSLayoutConstraint?) {
        var widthConstraint: NSLayoutConstraint? = nil
        var heightConstraint: NSLayoutConstraint? = nil
        if let _width = width  {
            widthConstraint = NSLayoutConstraint(
                item: self,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .width,
                multiplier: 1.0,
                constant: _width)
            self.addConstraint(widthConstraint!)
        }
        if let _height = height {
            heightConstraint = NSLayoutConstraint(
                item: self,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .height,
                multiplier: 1.0,
                constant: _height)
            self.addConstraint(heightConstraint!)
        }

        return (widthConstraint, heightConstraint)
    }
}
