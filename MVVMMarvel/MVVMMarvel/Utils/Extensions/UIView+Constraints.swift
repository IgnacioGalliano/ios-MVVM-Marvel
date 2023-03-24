//
//  UIView+Constraints.swift
//  MVVMMarvel
//
//  Created by Nacho on 06/03/2022.
//

import UIKit

public typealias Constraint = (_ layoutView: UIView) -> NSLayoutConstraint

//
// Solution based on http://chris.eidhof.nl/post/micro-autolayout-dsl/
//
public extension UIView {
    /// Adds constraints using NSLayoutAnchors, based on description provided in params.
    /// Please refer to helper equal functions for info how to generate constraints easily.
    ///
    /// - Parameter constraintDescriptions: constrains array
    /// - Returns: created constraints
    @discardableResult
    func addConstraints(_ constraintDescriptions: [Constraint]) -> [NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraints = constraintDescriptions.map { $0(self) }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /// Remove all constraints from view and it subviews
    func removeAllConstraints() {
        removeConstraints(constraints)
        subviews.forEach { $0.removeAllConstraints() }
    }
}

/// Describes constraint that is equal to constraint from different view.
/// Example: `equal(superView, \.centerXAnchor) will align view centerXAnchor to superview centerXAnchor`
///
/// - Parameters:
///   - view: that constrain should relate to
///   - to: constraints key path
/// - Returns: created constraint
public func equal<Anchor, Axis>(_ view: UIView,
                                _ to: KeyPath<UIView, Anchor>) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return { layoutView in
        layoutView[keyPath: to].constraint(equalTo: view[keyPath: to])
    }
}

/// Describes constraint that will be equal to constant
/// Example: `equal(\.heightAnchor, to: 36) will create height constraint with value 36`
///
/// - Parameters:
///   - keyPath: constraint key path
///   - constant: value
/// - Returns: created constraint
public func equal<LayoutDimension>(_ keyPath: KeyPath<UIView, LayoutDimension>,
                                   to constant: CGFloat) -> Constraint where LayoutDimension: NSLayoutDimension {
    return { layoutView in
        layoutView[keyPath: keyPath].constraint(equalToConstant: constant)
    }
}

/// Describes constraint that will be greater or equal to constant
/// Example: `equal(\.heightAnchor, greaterOrEqual: 36) will create height constraint with value greater or equal 36`
///
/// - Parameters:
///   - keyPath: constraint key path
///   - constant: value
/// - Returns: created constraint
public func equal<LayoutDimension: NSLayoutDimension>(_ keyPath: KeyPath<UIView, LayoutDimension>,
                                                      greaterOrEqual constant: CGFloat) -> Constraint {
    return { layoutView in
        layoutView[keyPath: keyPath].constraint(greaterThanOrEqualToConstant: constant)
    }
}

/// Describes constraint that will be less or equal to constant
/// Example: `equal(\.heightAnchor, lessOrEqual: 36) will create height constraint with value less or equal 36`
///
/// - Parameters:
///   - keyPath: constraint key path
///   - constant: value
/// - Returns: created constraint
public func equal<LayoutDimension: NSLayoutDimension>(_ keyPath: KeyPath<UIView, LayoutDimension>,
                                                      lessOrEqual constant: CGFloat) -> Constraint {
    return { layoutView in
        layoutView[keyPath: keyPath].constraint(lessThanOrEqualToConstant: constant)
    }
}

/// Describes relation between constraints of two views.
/// Example: `equal(logoImageView, \.heightAnchor, \.heightAnchor, ratio: 0.5)
/// will create constraint where height of current view is expected to be half of the logoImageView height
///
/// - Parameters:
///   - view: view that constraint is related from
///   - keyPath: constraint key path of current view
///   - to: constraint key path of related view
///   - value: the multiplier constant for the constraint.
/// - Returns: created constraint
public func equal<LayoutDimension>(_ view: UIView,
                                   _ keyPath: KeyPath<UIView, LayoutDimension>,
                                   _ to: KeyPath<UIView, LayoutDimension>,
                                   ratio value: CGFloat) -> Constraint where LayoutDimension: NSLayoutDimension {
    return { layoutView in
        layoutView[keyPath: keyPath].constraint(equalTo: view[keyPath: to], multiplier: value)
    }
}

/// Describes relation between constraints of two views
/// Example: `equal(logoImageView, \.topAnchor, \.bottomAnchor, constant: 80)`
/// will create constraint where topAnchor of current view is linked to bottomAnchor of passed view with offset 80
///
/// - Parameters:
///   - view: view that constraint is related from
///   - from: constraint key path of current view
///   - to: constraint key path of related view
///   - constant: value
/// - Returns: created constraint
public func equal<Anchor, Axis>(_ view: UIView,
                                _ from: KeyPath<UIView, Anchor>,
                                _ to: KeyPath<UIView, Anchor>,
                                constant: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return { layoutView in
        layoutView[keyPath: from].constraint(equalTo: view[keyPath: to], constant: constant)
    }
}

/// Describes relation between constraints of two views
/// Example: `equal(logoImageView, \.topAnchor, \.bottomAnchor, constant: 80)`
/// will create constraint where topAnchor of current view is linked to bottomAnchor of passed view with offset less or equal 80
///
/// - Parameters:
///   - view: view that constraint is related from
///   - from: constraint key path of current view
///   - to: constraint key path of related view
///   - lessOrEqual: value
/// - Returns: created constraint
public func equal<Anchor, Axis>(_ view: UIView,
                                _ from: KeyPath<UIView, Anchor>,
                                _ to: KeyPath<UIView, Anchor>,
                                lessOrEqual: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return { layoutView in
        layoutView[keyPath: from].constraint(lessThanOrEqualTo: view[keyPath: to], constant: lessOrEqual)
    }
}

/// Describes relation between constraints of two views
/// Example: `equal(logoImageView, \.topAnchor, \.bottomAnchor, constant: 80)`
/// will create constraint where topAnchor of current view is linked to bottomAnchor of passed view with offest greater or equal to 80
///
/// - Parameters:
///   - view: view that constraint is related from
///   - from: constraint key path of current view
///   - to: constraint key path of related view
///   - greaterOrEqual: value
/// - Returns: created constraint
public func equal<Anchor, Axis>(_ view: UIView,
                                _ from: KeyPath<UIView, Anchor>,
                                _ to: KeyPath<UIView, Anchor>,
                                greaterOrEqual: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return { layoutView in
        layoutView[keyPath: from].constraint(greaterThanOrEqualTo: view[keyPath: to], constant: greaterOrEqual)
    }
}

/// Describes constraints from diffrent views where anchors should match with passed offset
/// Example: `equal(self, \.bottomAnchor, constant: -37)` will align bottomAnchors of current and passed view with offset -37
///
/// - Parameters:
///   - view: view that constraint is related from
///   - keyPath: constraint key path
///   - constant: value
/// - Returns: created constraint
public func equal<Axis, Anchor>(_ view: UIView,
                                _ keyPath: KeyPath<UIView, Anchor>,
                                constant: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
    return equal(view, keyPath, keyPath, constant: constant)
}


