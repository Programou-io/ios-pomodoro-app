import XCTest

extension XCTestCase {
    func trackMemmoryLeak(
        _ instance: AnyObject,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "\(String(describing: instance)) must be nil, potential memmory leak was found",
                file: file,
                line: line
            )
        }
    }
}
