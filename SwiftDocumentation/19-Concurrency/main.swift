//
//  main.swift
//  Concurrency
//
//  Created by wooyoung on 2023/08/21.
//

import Foundation

/*
 parallel: 동시 작업
 async code: suspended and resumed later
 
 ex)
 actor를 이용해 mutable state에 안전하게 접근하기
 concurrency는 디버깅을 어렵게 한다.
 
 스위프트의 컨커런시는 컴파일 타임에서 문제를 해결하도록 돕는다
 
 concurrency = async + paralle code
 */

/*
 스위프트의 concurrency는 쓰레드와 직접적으로 상호작용 하지 않는다.
 비동기 함수는 재실행될 때 동일한 쓰레드에서 실행되는 것을 보장하지 않는다.
 
 swift concurrency 없이도 작업은 할 수 있지만 가독성이 떨어진다(callback)
 */

//  MARK: Defining and calling asynchronous functions

//  async method는 다른 작업이 끝날 때까지 지연될 수 있다.

/*
 참고
 function: 전역적으로 사용되는 함수
 method: 특정 타입 내에 정의된 함수
 */

func listPhotos(inGallery name: String) async -> [String] {
    
    let result = ["상영", "원영", "우영"] // 네트워크 작업이라 가정
    
    return result
}

//  await 키워드로 async 호출
//  await = possible suspension point
//  모든 suspension은 explicit.

let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]

/*
 특정 지점에서만 await 호출 가능
 
 - async 함수 내부(body)
 - @main으로 선언된 타입의 static main method
 - unstructured child task
 */

func add(_ photo: [String], toGallery gallery: String) {
    
}

func remove(_ photo: [String], fromGallery gallery: String) {
    
}

func download(_ name: String) async -> Data {
    return Data()
}

let photos = await listPhotos(inGallery: "Summer Vacation")

//  이 사이에 await 올 수도 있음.
//  이 경우 photos가 불필요하게 오래있게 된다.
add(photos, toGallery: "Road Trip")
remove(photos, fromGallery: "Summer Vacation")

//  아래처럼 리팩터. 동기함수니까 중간에 비동기 함수 실행될 우려가 없다
func move(_ photos: [String], from source: String, to destination: String) {
    
}

//  MARK: Asynchronous sequences

let handle = FileHandle.standardInput

//  for with await
//  사용하려면 AsyncSequence 프로토콜을 채택해야한다
for try await line in handle.bytes.lines {
    print(line)
}

//  MARK: Caling asynchronous functions in parallel

/*
 await으로 실행된 코드는 한번에 하나만 동작한다
 서로 순서가 무관한 경우 성능에 결함ㅇ ㅣ있다
 
 동시에 해도 되는 경우 async로 실행
 */

async let firstPhoto = listPhotos(inGallery: "first")
async let secondPhoto = listPhotos(inGallery: "second")
async let thirdPhoto = listPhotos(inGallery: "third")

//  세 작업은 병렬적으로 실행된다
let photos2 = await [firstPhoto, secondPhoto, thirdPhoto]

/*
 await은 순차적이다. 첫번째 함수가 다음 함수에 영향을 미친다.
 async let은 반대.
 */

//  MARK: Tasks and Task groups

/*
 Task: 프로그램이 비동기적으로 실행되는 단위.
 모든 async 함수는 task
 
 async let은 child task를 만든다
 
 task group을 만들고 child task를 그룹에 추가할 수 있다.
 우선순위와 취소 제어가 가능하다
 
 Task group안의 task는 동일한 parent task를 갖는다
 각 task는 child task를 갖는다
 task와 task group 간의 관계가 명확해 structured concurreny라고 한다.
 
 
 */

//  addTask에서 반환되는 타입은 of 타입과 동일하게
await withTaskGroup(of: Data.self, body: { taskGroup in
    let photoNames = await listPhotos(inGallery: "Summer vacation")
    
    for photoName in photoNames {
        // 우선 순위 지정 가능
        taskGroup.addTask(priority: .high) { await download(photoName) }
    }
})

/*
 structured concurrency란?
 async let, withTaskGroup으로 만들어진 task
 
 이걸 사용하는게 좋은 이유는? propagate cancellation이 유리하다.
 = parent task의 취소에 따른 child task 취소를 관리하기 편하다
 
 child task가 모두 실행되어야 parent task가 완료된다.
 
 가능하면 unstructure보다는 structured를 사용.
 unstructured는 동기 함수에서 비동기 함수 만들때 사용
 */

//  MARK: Unstructured concurrency

/*
 스위프트는 unstructured concurrency도 지원한다.
 task group의 task와는 달리 parent task를 갖지 않는다
 
 필요한 작업을 관리하기는 쉬우나 정확성에 대한 책임을 내가 보장해야한다.
 
 자세한 정보는 Task에서
 */

let unstructuredConcurrency = Task {
    return await listPhotos(inGallery: "")
}

let result = await unstructuredConcurrency.value

//  MARK: Task cancellation

/*
 
 아래 두개는 cancel 확인하는 방법
 Task.checkCancellation(): task가 취소될 경우 CancellationError 반환
 Task.isCancelled: 단순히 취소만 확인하는 방법
 
 Task.cancel(): 내가 task 취소하는 방법.
 */

//  MARK: Actor

//  task간에 정보 공유하는 방법
//  actor는 클래스처럼 reference type
//  mutable state에는 한번에 하나의 actor만 접근할 수 있다

actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    
    private(set) var max: Int


    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max) //  actor의 메소드와 프로퍼티는 potential sespension point이므로 await으로 접근한다

//  actor 내부에서 프로퍼티/메소드에 접근할 때는 await 호출 없어도 된다
//  이미 외부에서 await으로 호출을 했다
extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}

/*
 actor는 이런 상황을 막는다
 
 A Task에서 update를 호출해서 measurements에 element를 하나 추가한다
 B Task에서 max를 읽는다
 A Task에서 max 값을 변경한다
 */

//  MARK: Sendable types

/*
 concurrency domain: task와 actor 내부에 있는 mutable state(property)
 
 sendable type: concurrency domatin 사이에서 공유되는 값 
 */
