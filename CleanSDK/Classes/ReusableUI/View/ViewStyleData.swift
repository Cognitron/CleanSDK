//
//  ViewStyleData.swift
//  CleanSDK
//
//  Created by Artem Eremeev on 13.11.2019.
//

import Foundation

struct ViewStyleData: Decodable {
    
    let cornerRadius: Float?
    
    let backgroundColor: String?
    let borderColor: String?
    let borderWidth: Float?
    
    let shadowRadius: Float?
    let shadowOffsetX: Float?
    let shadowOffsetY: Float?
    let shadowColor: String?
    
}
