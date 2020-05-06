import Foundation
import Combine

extension Publisher {
    func unwrap<T>() -> Publishers.CompactMap<Self, T> where Output == Optional<T> {
        compactMap { $0 }
    }
}

extension Publisher where Output == String, Failure == Never {
    
    func changeWhiteSpaces(to replacement: String) ->AnyPublisher<String, Never> {
        map { $0.replacingOccurrences(of: " ", with: replacement) }
            .eraseToAnyPublisher()
    }
    
}

public func runSimplePublisher(attachOn resources: inout Set<AnyCancellable>) {
    let values: [Int?] = [1, 2, nil, 3, nil, 4]
    
    values.publisher
        .unwrap()
        .sink { print("unwrap, received value: \($0)") }
        .store(in: &resources)
    
    let stringValues = ["Hello world", "Hello world 2"]
    
    stringValues.publisher
        .changeWhiteSpaces(to: "*")
        .sink { print("whitespaces, received value: \($0)") }
        .store(in: &resources)
}
