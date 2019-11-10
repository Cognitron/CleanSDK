//
//  SafariConstructor.swift
//  Clean
//
//  Created by Artem Eremeev on 12/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import SafariServices

public class SafariConstructor: SystemActionConstructorType {
    
    private let safariController: SFSafariViewController
    
    public convenience init(urlString: String) {
        self.init(url: URL(string: urlString)!)
    }
    
    public init(url: URL) {
        safariController = SFSafariViewController(url: url)
    }
    
    public func show() {
        present(controller: safariController)
    }
    
}
