import XCTest
@testable import MultipartFormBuffer

final class MultipartFormBufferTests: XCTestCase {
    func keyValueTest() {
        let name = "test-name"
        let value = "test-value"
        
        let buffer = MultipartFormBuffer()
        buffer.addValue(name: name, value: value)
        
        let bufferedData = buffer.get()
        let bufferedString = String.init(data: bufferedData, encoding: .utf8)
        
        XCTAssert(bufferedString != nil)
        XCTAssert(bufferedString?.contains(value) ?? false)
        XCTAssert(bufferedString?.contains("Content-Disposition: form-data; name=\"\(name)\"") ?? false)
    }

    static var allTests = [
        ("keyValueTest", keyValueTest),
    ]
}
