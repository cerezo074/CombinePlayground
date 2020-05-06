import Foundation
import Combine

private var timer: Timer.TimerPublisher?

public func runBackPressure(attachOn resources: inout Set<AnyCancellable>) {
    let subscription = [1, 2, 3, 4, 5, 6].publisher
//        .buffer(size: 20, prefetch: .keepFull, whenFull: .dropNewest)
        .pausableSink(receiveCompletion: { completion in
            print("Pausable subscription completed: \(completion)")
        },
        receiveValue: { value -> Bool in
            print("Receive value: \(value)")
            
            if value % 2 == 1 {
                print("Pausing")
                return false
            }
            
            return true
        })
    
    Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
        .sink { _ in
            guard subscription.paused else { return }
            print("Subscription is paused, resuming")
            subscription.resume()
        }.store(in: &resources)
}
