import XCTest
@testable import IndegeneAssignment

class ContentJsonParsingTests: XCTestCase {
    
    var contentModel: Content?
    let repository = IndgeneContentRepository()
    
    override func setUp() {
        let json = try? repository.loadJSON(name: "contentModel")
        contentModel = try? Content(json: json!)
    }
    
    func testContentReturnCorrectUrl() {
        let expectedUrl = "https://clientarea.indegene.com/sharemax/retrieve.jsp?id=fd7b185a-58e7-4e1f-9870-654736d9fa2d"
        
        XCTAssertEqual(contentModel?.contentType.url(), expectedUrl)
    }
    
    func testContentReturnCorrectType() {
        if case .image(_)? = contentModel?.contentType {
            XCTAssert(true, "type match")
        } else {
            XCTFail("Not matching type")
        }
    }
}
