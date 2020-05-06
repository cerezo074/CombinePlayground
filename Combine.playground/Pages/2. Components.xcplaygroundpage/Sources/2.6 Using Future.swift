import Foundation
import Combine

func futureIncrement(integer: Int, afterDelay delay: TimeInterval) -> Future<Int, Never> {
  Future<Int, Never> { promise in
    print("Future created and run inmedeatly")
    DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
        promise(.success(Int.random(in: 0...integer)))
    }
  }
}

public func runFuture(attachOn resources: inout Set<AnyCancellable>) {
    let future = futureIncrement(integer: 1, afterDelay: 3)
    
    future
        .sink(receiveCompletion: { print("First", $0) },
              receiveValue: { print("First", $0) })
        .store(in: &resources)
    
    future
        .sink(receiveCompletion: { print("Second", $0) },
              receiveValue: { print("Second", $0) })
        .store(in: &resources)
}
