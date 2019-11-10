//
//  Localization.swift
//  Clean
//
//  Created by Artem Eremeev on 13/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift

public class Localization {
    
    private struct Keys {
        static let currentLocalization = "cln_localization_current_localization"
    }
    
    public lazy var currentLocalization: Observable<String> = {
        return UserDefaults.standard.rx
            .observe(String.self, Keys.currentLocalization)
            .map({ $0 ?? Locale.preferredLanguages.first ?? "en" }).share()
    }()
    
    public func localize(key: String, forButton button: UIButton, property: LocalizationButtonProperty = .normalTitle) -> Disposable {
        switch property {
        case .normalTitle: return localization(forKey: key).bind(to: button.rx.title(for: .normal))
        case .highlightedTitle: return localization(forKey: key).bind(to: button.rx.title(for: .highlighted))
        case .selectedTitle: return localization(forKey: key).bind(to: button.rx.title(for: .selected))
        }
    }
    
    public func localize(key: String, forLabel label: UILabel) -> Disposable {
        return localization(forKey: key).bind(to: label.rx.text)
    }
    
    public func localize(key: String, forTextField textField: UITextField, property: LocalizationTextFieldProperty = .placeholder) -> Disposable {
        switch property {
        case .placeholder: return localization(forKey: key).bind(onNext: { textField.placeholder = $0 })
        }
    }
    
    public func localize(key: String, forNavigationItem navigationItem: UINavigationItem) -> Disposable {
        return localization(forKey: key).bind(to: navigationItem.rx.title)
    }

    // MARK: private
    
    private func string(forKey key: String, languageCode: String) -> String {
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
            let bundle = Bundle(path: path) else {
            return ""
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    private func localization(forKey key: String) -> Observable<String> {
        return currentLocalization.map({ languageCode in
            return self.string(forKey: key, languageCode: languageCode)
        })
    }
    
}
