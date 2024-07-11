//
//  ResponseDecoder.swift
//  Filmatica
//
//  Created by Siros Taib on 7/11/24.
//

import Foundation
import RxSwift

class ResponseDecoder {
    func decodeResponse<T: Decodable>(data: Data, responseType: T.Type) -> Observable<T> {
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return Observable.just(decodedObject)
        } catch {
            return Observable.error(NetworkError.parsingError)
        }
    }
}
