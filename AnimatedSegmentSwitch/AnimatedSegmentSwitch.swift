//
//  AnimatedSegmentSwitch.swift
//  AnimatedSegmentSwitch
//
//  Created by Tobias Schmid on 09/18/2015.
//  Copyright (c) 2015 Tobias Schmid. All rights reserved.
//

import UIKit

// MARK: - AnimatedSegmentSwitch

@IBDesignable open class AnimatedSegmentSwitch: UIControl {

    // MARK: - Public Properties

    @objc open var items: [String] = ["Item 1", "Item 2", "Item 3"] {
        didSet {
            setupLabels()
        }
    }

    @objc open var selectedIndex: Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }

    @objc open var animationDuration: TimeInterval = 0.5
    @objc open var animationSpringDamping: CGFloat = 0.6
    @objc open var animationInitialSpringVelocity: CGFloat = 0.8

    // MARK: - IBInspectable Properties

    @IBInspectable open var selectedTitleColor: UIColor = UIColor.black {
        didSet {
            setSelectedColors()
        }
    }

    @IBInspectable open var titleColor: UIColor = UIColor.white {
        didSet {
            setSelectedColors()
        }
    }

    @IBInspectable open var font: UIFont! = UIFont.systemFont(ofSize: 12) {
        didSet {
            setFont()
        }
    }

    @IBInspectable open var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable open var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable open var thumbColor: UIColor = UIColor.white {
        didSet {
            setSelectedColors()
        }
    }

    @IBInspectable open var thumbCornerRadius: CGFloat = 0.0 {
        didSet {
            thumbView.layer.cornerRadius = thumbCornerRadius
        }
    }

    @IBInspectable open var thumbInset: CGFloat = 2.0 {
        didSet {
            setNeedsLayout()
        }
    }

    // MARK: - Private Properties

    fileprivate var labels = [UILabel]()
    fileprivate var selectedlabels = [UILabel]()
    fileprivate var titleLabelsContentView = UIView()
    fileprivate var selectedTitleLabelsContentView = UIView()
    fileprivate var thumbView = UIView()
    fileprivate var thumbViewMask = UIView()
    fileprivate var selectedThumbViewFrame: CGRect?
    fileprivate var panGesture: UIPanGestureRecognizer!

    // MARK: - Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    fileprivate func setupView(){
        backgroundColor = .clear

        addSubview(thumbView)

        titleLabelsContentView.frame = bounds
        addSubview(titleLabelsContentView)


        selectedTitleLabelsContentView.frame = bounds
        addSubview(selectedTitleLabelsContentView)

        addSubview(thumbViewMask)

        selectedTitleLabelsContentView.layer.mask = thumbViewMask.layer

        setupLabels()

        titleLabelsContentView.isUserInteractionEnabled = false
        selectedTitleLabelsContentView.isUserInteractionEnabled = false
        thumbViewMask.isUserInteractionEnabled = false

        panGesture = UIPanGestureRecognizer(target: self, action: #selector(AnimatedSegmentSwitch.pan(_:)))
        panGesture.delegate = self
        addGestureRecognizer(panGesture)
    }

    fileprivate func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }

        for label in selectedlabels {
            label.removeFromSuperview()
        }

        labels.removeAll(keepingCapacity: true)
        selectedlabels.removeAll(keepingCapacity: true)

        for index in 1...items.count {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 40))
            label.text = items[index - 1]
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.font = font
            label.textColor = titleColor
            label.translatesAutoresizingMaskIntoConstraints = false

            let selectedLabel = UILabel(frame: label.frame)
            selectedLabel.text = label.text
            selectedLabel.backgroundColor = .clear
            selectedLabel.textAlignment = .center
            selectedLabel.font = font
            selectedLabel.textColor = selectedTitleColor
            selectedLabel.translatesAutoresizingMaskIntoConstraints = false

            titleLabelsContentView.addSubview(label)
            selectedTitleLabelsContentView.addSubview(selectedLabel)
            labels.append(label)
            selectedlabels.append(selectedLabel)
        }

        addIndividualItemConstraints(labels, mainView: self, padding: thumbInset)
        addIndividualItemConstraints(selectedlabels, mainView: self, padding: thumbInset)
    }

    // MARK: - Touch Events

    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        if let index = indexAtLocation(location) {
            selectedIndex = index
            sendActions(for: .valueChanged)
        }
        return false
    }

    @objc func pan(_ gesture: UIPanGestureRecognizer!) {
        if gesture.state == .began {
            selectedThumbViewFrame = thumbView.frame
        } else if gesture.state == .changed {
            var frame = selectedThumbViewFrame!
            frame.origin.x += gesture.translation(in: self).x
            frame.origin.x = max(min(frame.origin.x, bounds.width - frame.width - thumbInset), thumbInset)
            thumbView.frame = frame
            thumbViewMask.frame = frame
        } else if gesture.state == .ended || gesture.state == .failed || gesture.state == .cancelled {
            let location = gesture.location(in: self)
            if let index = nearestIndexAtLocation(location: location) {
                selectedIndex = index
                sendActions(for: .valueChanged)
            }
        }
    }

    // MARK: - Layout

    override open func layoutSubviews() {
        super.layoutSubviews()

		layer.cornerRadius = (cornerRadius == 0.0) ? frame.height / 2 : cornerRadius
        layer.borderColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true

        var selectFrame = self.bounds
        let newWidth = selectFrame.width / CGFloat(items.count)
        selectFrame.size.width = newWidth - thumbInset * 2
        selectFrame.size.height = selectFrame.height - thumbInset * 2
        selectFrame.origin.x = thumbInset
        selectFrame.origin.y = thumbInset

        thumbView.frame = selectFrame
        thumbView.backgroundColor = thumbColor
		thumbView.layer.cornerRadius = (thumbCornerRadius == 0.0) ? thumbView.frame.height / 2 : thumbCornerRadius

        thumbViewMask.frame = thumbView.frame
        thumbViewMask.backgroundColor = UIColor.white
        thumbViewMask.layer.cornerRadius = thumbView.layer.cornerRadius
    }

    // MARK: - Private - Helpers

    fileprivate func displayNewSelectedIndex() {
        self.layoutIfNeeded()
        let label = self.labels[self.selectedIndex]

        UIView.animate(withDuration: animationDuration,
            delay: 0.0,
            usingSpringWithDamping: animationSpringDamping,
            initialSpringVelocity: animationInitialSpringVelocity,
            options: [.beginFromCurrentState],
            animations: {
                self.thumbView.frame = label.frame
                self.thumbViewMask.frame = label.frame
            },
            completion: { (completed) in
                // was causing stuttering when chaning values fast
                // self.thumbView.frame = label.frame
                // self.thumbViewMask.frame = label.frame
        })
    }

    fileprivate func setSelectedColors() {
        thumbView.backgroundColor = self.thumbColor
        for label in self.selectedlabels {
            label.textColor = selectedTitleColor
        }
    }

    fileprivate func setFont() {
        for item in self.labels {
            item.font = font
        }
        for item in selectedlabels {
            item.font = font
        }
    }

    fileprivate func indexAtLocation(_ location: CGPoint) -> Int? {
        var calculatedIndex: Int?
        for (index, item) in labels.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
                break
            }
        }
        return calculatedIndex
    }

    fileprivate func nearestIndexAtLocation(location: CGPoint) -> Int? {
        var calculatedDistances : [CGFloat] = []
        for (index, item) in labels.enumerated() {
            let distance = sqrt(pow(location.x - item.center.x, 2) + pow(location.y - item.center.y, 2))
            calculatedDistances.insert(distance, at: index)
        }
        return calculatedDistances.firstIndex(of: calculatedDistances.min()!)!
    }

    fileprivate func addIndividualItemConstraints(_ items: [UIView], mainView: UIView, padding: CGFloat) {
        for (index, button) in items.enumerated() {
            let topConstraint = NSLayoutConstraint(item: button,
                                                   attribute: NSLayoutConstraint.Attribute.top,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: mainView,
                attribute: NSLayoutConstraint.Attribute.top,
                multiplier: 1.0,
                constant: padding)

            let bottomConstraint = NSLayoutConstraint(item: button,
                                                      attribute: NSLayoutConstraint.Attribute.bottom,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: mainView,
                attribute: NSLayoutConstraint.Attribute.bottom,
                multiplier: 1.0,
                constant: -padding)

            var rightConstraint : NSLayoutConstraint!
            if index == items.count - 1 {
                rightConstraint = NSLayoutConstraint(item: button,
                                                     attribute: NSLayoutConstraint.Attribute.right,
                                                     relatedBy: NSLayoutConstraint.Relation.equal,
                    toItem: mainView,
                    attribute: NSLayoutConstraint.Attribute.right,
                    multiplier: 1.0,
                    constant: -padding)
            } else {
                let nextButton = items[index+1]
                rightConstraint = NSLayoutConstraint(item: button,
                                                     attribute: NSLayoutConstraint.Attribute.right,
                                                     relatedBy: NSLayoutConstraint.Relation.equal,
                    toItem: nextButton,
                    attribute: NSLayoutConstraint.Attribute.left,
                    multiplier: 1.0,
                    constant: -padding)
            }

            var leftConstraint : NSLayoutConstraint!
            if index == 0 {
                leftConstraint = NSLayoutConstraint(item: button,
                                                    attribute: NSLayoutConstraint.Attribute.left,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                    toItem: mainView,
                    attribute: NSLayoutConstraint.Attribute.left,
                    multiplier: 1.0,
                    constant: padding)
            } else {
                let prevButton = items[index-1]
                leftConstraint = NSLayoutConstraint(item: button,
                                                    attribute: NSLayoutConstraint.Attribute.left,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                    toItem: prevButton,
                    attribute: NSLayoutConstraint.Attribute.right,
                    multiplier: 1.0,
                    constant: padding)

                let firstItem = items[0]
                let widthConstraint = NSLayoutConstraint(item: button,
                    attribute: .width,
                    relatedBy: NSLayoutConstraint.Relation.equal,
                    toItem: firstItem,
                    attribute: .width,
                    multiplier: 1.0,
                    constant: 0)

                mainView.addConstraint(widthConstraint)
            }

            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
}

// MARK: - UIGestureRecognizer Delegate
extension AnimatedSegmentSwitch: UIGestureRecognizerDelegate {

    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGesture {
            return thumbView.frame.contains(gestureRecognizer.location(in: self))
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}
