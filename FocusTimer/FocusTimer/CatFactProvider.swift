//
//  CatFactProvider.swift
//  FocusTimer
//

import Combine

public enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

protocol CatFactProvider {
    func randomFact(completion: @escaping((Result<RandomFact, APIError>) -> Void))
    func randomFact() -> AnyPublisher<RandomFact, APIError>
}
