//
//  Extensions.swift
//  GiorgiPilishvili_Homework15
//
//  Created by GIORGI PILISSHVILI on 14.07.22.
//

import Foundation
import UIKit

// MARK: Extensions for CollectionViewCell

extension UICollectionViewCell {
    
    static var identifier: String { String(describing: self) }
    static var nibFile: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
}

extension UICollectionView {
    
    func registerNib<T: UICollectionViewCell>(class: T.Type) {
        self.register(T.nibFile, forCellWithReuseIdentifier: T.identifier)
    }
}

// MARK: Extension for lable border

extension UILabel {

    func setOutLinedText(_ text: String) {
        let attribute : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeWidth : -2.0,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)
            ] as [NSAttributedString.Key  : Any]

        let customizedText = NSMutableAttributedString(string: text,
                                                       attributes: attribute)
        attributedText = customizedText
     }
}

// MARK: Extension for blur image

extension UIView {
    func addBlur() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }

    func removeBlur() {
        for subview in self.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
}

//protocol Blurable: UIView {
//    var blurEffectView: UIVisualEffectView? { set get }
//
//    func applyBlur(with effect: UIBlurEffect.Style)
//    func removeBlur()
//}
//
//private var xoAssociationKey: UInt8 = 0
//
//extension Blurable where Self: UIImageView {
//
//    // If you want to avoid adding "blurEffectView" to each UIView class,
//    // you can do it this way
//    var blurEffectView: UIVisualEffectView? {
//        get {
//            return objc_getAssociatedObject(self, &xoAssociationKey) as? UIVisualEffectView
//        }
//
//        set(newBlurEffectView) {
//            objc_setAssociatedObject(self, &xoAssociationKey, newBlurEffectView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//        }
//    }
//
//    func applyBlur(with effect: UIBlurEffect.Style) {
//        let blurEffect = UIBlurEffect(style: effect)
//        blurEffectView = UIVisualEffectView(effect: blurEffect)
//
//        blurEffectView?.frame = bounds
//        blurEffectView?.alpha = 0.8
//
//        if let blurEffectView = blurEffectView { addSubview(blurEffectView) }
//    }
//
//    func removeBlur() {
//        if let blurEffectView = blurEffectView {
//            blurEffectView.removeFromSuperview()
//        }
//
//        blurEffectView = nil
//    }
//}
//
//extension UIImageView: Blurable {}
