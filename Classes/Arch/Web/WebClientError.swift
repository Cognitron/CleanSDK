//
//  WebClientError.swift
//  Clean
//
//  Created by Artem Eremeev on 12/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation

public enum WebClientError: Error, LocalizedError {
    case requestCreating
    case decoding
    case noDataForDecoding
    case notConnectedToInternet
    case timedOut
    case unknown(body: String)
    
    var body: String? {
        switch self {
        case let .unknown(body):
            return body
        default:
            return nil
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .requestCreating:
            return "Не удалось сериализовать запрос"
        case .decoding:
            return "Не удалось декодировать объект"
        case .noDataForDecoding:
            return "Данные для декодирования отсутствуют"
        case .notConnectedToInternet:
            return "Отсутствует подключение к интернету"
        case .timedOut:
            return "Время ожидания запроса истекло"
        case .unknown:
            return "Неизвестная ошибка"
        }
    }
}
