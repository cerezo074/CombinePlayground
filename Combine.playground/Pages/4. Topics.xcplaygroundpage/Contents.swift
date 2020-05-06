/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

//: [Previous](@previous)

import Foundation
import Combine

var subscriptions: Set<AnyCancellable> = []

/*:
 # Networking
 
 
 - Data transfer tasks to retrieve the content of a URL. (ONLY)
 - Download tasks to retrieve the content of a URL and save it to a file.
 - Upload tasks to upload files and data to a URL.
 - Stream tasks to stream data between two parties.
 - Websocket tasks to connect to websockets.
 
 */

//example(of: "Codable") {
//    struct MyType: Decodable {
//        let message: String
//    }
//
//    let url = URL(string: "https://mysite.com/mydata.json")!
//    let subscription = URLSession.shared
//        .dataTaskPublisher(for: url)
//    //    .tryMap { data, _ in
//    //        try JSONDecoder().decode(MyType.self, from: data) //LONG WAY!
//    //    }
//        .map(\.data)
//        .decode(type: MyType.self, decoder: JSONDecoder())
//        .sink(receiveCompletion: { completion in
//            if case .failure(let err) = completion {
//                print("Retrieving data failed with error \(err)")
//            }
//        }, receiveValue: { object in
//        print("Retrieved object \(object)")
//        })
//}

/*:
# Debugging
*/

//example(of: "Print") {
//    [1,3,4,5,6,7].publisher
//        .print("publisher", to: TimeLogger())
//        .sink { _ in }
//        .store(in: &subscriptions)
//}
//
//example(of: "Side Effects") {
//    let url = URL(string: "https://www.raywenderlich.com/")!
//    let request = URLSession.shared.dataTaskPublisher(for: url)
//
//    request.sink(receiveCompletion: { completion in
//        print("Sink received completion: \(completion)")
//    }) { (data, _) in
//        print("Sink received data: \(data)")
//    }
//
//    request
//        .handleEvents(receiveSubscription: { _ in
//            print("Network request will start")
//        }, receiveOutput: { _ in
//            print("Network request data received")
//        }, receiveCancel: {
//            print("Network request cancelled")
//        })
//        .sink(receiveCompletion: { completion in
//            print("Sink received completion: \(completion)")
//        }) { (data, _) in
//            print("Sink received data: \(data)")
//        }
//
//}
//
//example(of: "BreakPoint") {
//    let numbers = [1,2,3,4,5,11,20,60,6,7].publisher
//
//    numbers.breakpoint(receiveOutput: { value in
//        return value > 10 && value < 15
//    })
//    .sink { _ in }
//    .store(in: &subscriptions)
//}

/*:
# Timers
*/

//example(of: "Timer") {
//    let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
//        .autoconnect()
//        .scan(0) { counter, _ in counter + 1 }
//
//    timerPublisher.sink { counter in
//        print("Counter is \(counter)")
//    }.store(in: &subscriptions)
//}

//example(of: "Timer - DispatchQueue") {
//    let queue = DispatchQueue.main
//    let source = PassthroughSubject<Int, Never>()
//    var counter = 0
//
//    queue.schedule(after: queue.now, interval: .seconds(1)) {
//        source.send(counter)
//        counter += 1
//    }.store(in: &subscriptions)
//
//    source.sink {
//      print("Timer emitted \($0)")
//    }.store(in: &subscriptions)
//}

/*:
# Resource Managment
*/

//example(of: "Share") {
//    let shared = URLSession.shared
//        .dataTaskPublisher(for: URL(string: "https://source.unsplash.com/random")!)
//        .map(\.data)
//        .print("shared")
//        .share()
//
//    shared.sink(receiveCompletion: { _ in },
//                receiveValue: { print("subscription1 received: '\($0)'") })
//        .store(in: &subscriptions)
//
//    shared.sink(receiveCompletion: { _ in },
//                receiveValue: { print("subscription2 received: '\($0)'") })
//        .store(in: &subscriptions)
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//        shared.sink(receiveCompletion: {
//            print("subscription3 completion \($0)")
//        },receiveValue: {
//            print("subscription3 received: '\($0)'")
//        }).store(in: &subscriptions)
//    }
//}

/*:
 ![](share1.png)
 ![](share2.png)
 */

//example(of: "Multicast") {
//    let subject = PassthroughSubject<Data, URLError>()
//
//    let multicasted = URLSession.shared
//        .dataTaskPublisher(for: URL(string: "https://source.unsplash.com/random")!)
//        .map(\.data)
//        .print("shared")
//        .multicast(subject: subject)
//
//    multicasted.sink(receiveCompletion: { print("subscription1 completion \($0)") },
//                     receiveValue: { print("subscription1 received: '\($0)'") })
//        .store(in: &subscriptions)
//
//    multicasted.sink(receiveCompletion: { print("subscription2 completion \($0)") },
//                     receiveValue: { print("subscription2 received: '\($0)'") })
//        .store(in: &subscriptions)
//
//    multicasted.connect().store(in: &subscriptions)
//
////    subject.send(Data())
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//        multicasted.sink(receiveCompletion: { print("subscription3 completion \($0)") },
//                         receiveValue: { print("subscription3 received: '\($0)'") })
//            .store(in: &subscriptions)
//        subject.send(Data())
//    }
//}

//example(of: "Future") {
//    func performSomeWork() -> Int {
//        return Int.random(in: 0 ..< 10)
//    }
//
//    let future = Future<Int, Error> { fulfill in
//        let result = performSomeWork()
//        fulfill(.success(result))
//    }
//
//    future.sink(receiveCompletion: { print("subscription1 completion \($0)") },
//                 receiveValue: { print("subscription1 received: '\($0)'") })
//    .store(in: &subscriptions)
//
//    future.sink(receiveCompletion: { print("subscription2 completion \($0)") },
//                 receiveValue: { print("subscription2 received: '\($0)'") })
//    .store(in: &subscriptions)
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//        future.sink(receiveCompletion: { print("subscription3 completion \($0)") },
//                    receiveValue: { print("subscription3 received: '\($0)'") })
//            .store(in: &subscriptions)
//    }
//}

//example(of: "Property Wrappers") {
//    class Person {
//        @Published var age: Int = 0
//    }
//
//    let juan = Person()
//
//    juan.$age.sink(receiveCompletion: { print("completion \($0)") },
//                   receiveValue: { print(" received: '\($0)'") })
//        .store(in: &subscriptions)
//
//    juan.age = 20

    /*
     //NOT WORKING, just to know(needs swift ui to understand this example)
     final class MoviesSelectedMenuStore: ObservableObject {
         @Published var menu: MoviesMenu

         init(selectedMenu: MoviesMenu) {
             self.menu = selectedMenu
         }
     }

     struct MoviesHome : View {
         @ObservedObject private var selectedMenu = MoviesSelectedMenuStore(selectedMenu: .popular)

         var body: some View {
             NavigationView {
                 Group {
                     if selectedMenu.menu == .genres {
                         GenresList()
                     } else {
                         MoviesHomeList(menu: $selectedMenu.menu)
                     }
                 }
           }
         }
     }
     */
//}
//: [Next](@next)
