// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
    func customLane() {
        desc("Description of what the lane does")
        logger.log(message: "Test log")
        // add actions here: https://docs.fastlane.tools/actions
        captureScreenshots()
        frameScreenshots()
    }
    
    func makeScreenshotsLane() {
        captureScreenshots()
        frameScreenshots()
    }
}
