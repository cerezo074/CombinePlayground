import Foundation
import Combine

public func runJust(attachOn resources: inout Set<AnyCancellable>) {
    let just = Just("Hello world!")
    
    just.sink(receiveCompletion: {
        print("Received completion(1)", $0)
    }, receiveValue: {
        print("Received value(1)", $0)
    }).store(in: &resources)
    
    just.sink(receiveCompletion: {
        print("Received completion(2)", $0)
    },receiveValue: {
        print("Received value(2)", $0)
    }).store(in: &resources)
}
