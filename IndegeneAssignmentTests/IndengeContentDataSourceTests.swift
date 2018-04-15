import XCTest
@testable import IndegeneAssignment

final class IndengeContentDataSourceTests: XCTestCase {
    
    func testLoadContentThrowErrorIfFileDoesnotExist() {
        let dataSource = IndengeContentDataSource(fileName: "Content1")
        XCTAssertThrowsError(try dataSource.loadContent())
    }
    
    func testLoadContentReturnCorrectNumberOfContent() {
        let dataSource = IndengeContentDataSource(fileName: "content")
        let contents = try? dataSource.loadContent()
        XCTAssertEqual(contents?.count, 6)
    }
    
    func testLoadContentReturnCorrectNumberOfImageContent() {
        let dataSource = IndengeContentDataSource(fileName: "content")
        let imageContents = try? dataSource.loadContent().filter { content in 
            switch content.contentType {
            case .image:
                return true
            default:
                return false
            }
        }
        XCTAssertEqual(imageContents?.count, 4)
    }
    
    func testLoadContentReturnCorrectNumberOfPDFContent() {
        let dataSource = IndengeContentDataSource(fileName: "content")
        let pdfContents = try? dataSource.loadContent().filter { content in
            switch content.contentType {
            case .pdf:
                return true
            default:
                return false
            }
        }
        XCTAssertEqual(pdfContents?.count, 1)
    }

    func testLoadContentReturnCorrectNumberOfVideoContent() {
        let dataSource = IndengeContentDataSource(fileName: "content")
        let videoContents = try? dataSource.loadContent().filter { content in
            switch content.contentType {
            case .video:
                return true
            default:
                return false
            }
        }
        XCTAssertEqual(videoContents?.count, 1)
    }

}
