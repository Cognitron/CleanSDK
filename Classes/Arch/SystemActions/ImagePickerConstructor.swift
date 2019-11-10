//
//  ImagePickerConstructor.swift
//  Clean
//
//  Created by Artem Eremeev on 12/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public class ImagePickerConstructor: NSObject, SystemActionConstructorType, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let imagePickerController: UIImagePickerController
    private let selectedOriginalImage = BehaviorRelay<UIImage?>(value: nil)
    
    private let close = PublishSubject<Void>()
    
    public init(sourceType: UIImagePickerController.SourceType) {
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.sourceType = sourceType
        
        super.init()
        
        self.imagePickerController.delegate = self
        self.imagePickerController.constructor = self
    }
    
    deinit {
        print("CLNImagePickerConstructor released")
    }
    
    public func show() -> Single<UIImage> {
        present(controller: imagePickerController)
        return selectedOriginalImage.skipWhile({ $0 == nil }).map({ $0! }).asObservable().take(1).asSingle()
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedOriginalImage.accept(info[.originalImage] as? UIImage)
        
        picker.dismiss(animated: true) {
            picker.constructor = nil 
        }
    }
    
}

fileprivate struct UIImagePickerAssociatedKeys {
    static var constructor: UInt8 = 0
}

fileprivate extension UIImagePickerController {
    var constructor: ImagePickerConstructor! {
        get { return objc_getAssociatedObject(self, &UIImagePickerAssociatedKeys.constructor) as? ImagePickerConstructor }
        set { objc_setAssociatedObject(self, &UIImagePickerAssociatedKeys.constructor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}
