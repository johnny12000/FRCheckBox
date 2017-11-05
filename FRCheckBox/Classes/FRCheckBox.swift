//
//  FRCheckBox.swift
//
//  Created by Nikola Ristic on 31/10/17.
//  Copyright © 2017 nr. All rights reserved.
//

import UIKit

@IBDesignable
open class FRCheckBox: UIButton {

    @IBInspectable public var activeColor: UIColor = UIColor.green {
        didSet {
            createImages()
        }
    }

    @IBInspectable public var inactiveColor: UIColor = UIColor.white {
        didSet {
            createImages()
        }
    }

    @IBInspectable public var thumbBackgroundColor: UIColor = UIColor.gray {
        didSet {
            createImages()
        }
    }

    // Images
    var checkedImage: UIImage!
    var uncheckedImage: UIImage!

    // Bool property
    public var isChecked: Bool = false {
        didSet {
            setImage(isChecked ? checkedImage : uncheckedImage, for: .normal)
        }
    }

    override open func awakeFromNib() {
        self.imageView?.contentMode = .scaleAspectFit
        self.imageView?.backgroundColor = UIColor.clear
        self.addTarget(self, action: #selector(buttonClicked(_:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
        createImages()
    }

    func createImages() {
        checkedImage = UIImage.createRadioButtonImage(CGSize(width: 100, height: 100),
                                                      backgroundColor: thumbBackgroundColor, dotColor: activeColor)
        uncheckedImage = UIImage.createRadioButtonImage(CGSize(width: 100, height: 100),
                                                        backgroundColor: thumbBackgroundColor, dotColor: inactiveColor)
    }

    @objc func buttonClicked(_ sender: UIButton) {
        if sender == self {
            if isChecked {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }

    override open func prepareForInterfaceBuilder() {
        setImage(isChecked ? checkedImage : uncheckedImage, for: .normal)
    }
}

extension UIImage {

    /// Creates a radio button thumb image.
    /// - parameter size:            Size of the thumb
    /// - parameter backgroundColor: Background color
    /// - parameter dotColor:        Dot color (inner circle color)
    /// - returns: Image object
    class func createRadioButtonImage(_ size: CGSize, backgroundColor: UIColor, dotColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)

        let circle = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        circle.lineWidth = 0
        backgroundColor.setFill()
        circle.fill()

        let circle1 = UIBezierPath(ovalIn: CGRect(x: size.width * 0.15, y: size.height * 0.15,
                                                  width: size.width * 0.7, height: size.height * 0.7))
        circle1.lineWidth = 0
        dotColor.setFill()
        circle1.fill()

        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
