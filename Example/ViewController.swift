//
//  ViewController.swift
//  Example
//
//  Created by Lasha Efremidze on 2/16/18.
//  Copyright © 2018 Lasha Efremidze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// Custom Gesture Framework

enum CheckmarkPhases {
    case notStarted
    case initialPoint
    case downStroke
    case upStroke
}

class CheckmarkGestureRecognizer : UIGestureRecognizer {
    var strokePhase : CheckmarkPhases = .notStarted
    var initialTouchPoint : CGPoint = CGPoint.zero
    var trackedTouch : UITouch? = nil
}

//override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
//    super.touchesBegan(touches, with: event)
//    if touches.count != 1 {
//        self.state = .failed
//    }
//
//    // Capture the first touch and store some information about it.
//    if self.trackedTouch == nil {
//        self.trackedTouch = touches.first
//        self.strokePhase = .initialPoint
//        self.initialTouchPoint = (self.trackedTouch?.location(in: self.view))!
//    } else {
//        // Ignore all but the first touch.
//        for touch in touches {
//            if touch != self.trackedTouch {
//                self.ignore(touch, for: event)
//            }
//        }
//    }
//}
//
//override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
//    super.touchesMoved(touches, with: event)
//    let newTouch = touches.first
//    // There should be only the first touch.
//    guard newTouch == self.trackedTouch else {
//        self.state = .failed
//        return
//    }
//    let newPoint = (newTouch?.location(in: self.view))!
//    let previousPoint = (newTouch?.previousLocation(in: self.view))!
//    if self.strokePhase == .initialPoint {
//        // Make sure the initial movement is down and to the right.
//        if newPoint.x >= initialTouchPoint.x && newPoint.y >= initialTouchPoint.y {
//            self.strokePhase = .downStroke
//        } else {         self.state = .failed
//        }
//    } else if self.strokePhase == .downStroke {
//        // Always keep moving left to right.
//        if newPoint.x >= previousPoint.x {
//            // If the y direction changes, the gesture is moving up again.
//            // Otherwise, the down stroke continues.
//            if newPoint.y < previousPoint.y {
//                self.strokePhase = .upStroke
//            }
//        } else {
//            // If the new x value is to the left, the gesture fails.
//            self.state = .failed
//        }
//    } else if self.strokePhase == .upStroke {
//        // If the new x value is to the left, or the new y value
//        // changed directions again, the gesture fails.]
//        if newPoint.x < previousPoint.x || newPoint.y > previousPoint.y {
//            self.state = .failed
//        }
//    }
//}
//
//override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
//    super.touchesEnded(touches, with: event)
//    let newTouch = touches.first
//    let newPoint = (newTouch?.location(in: self.view))!
//    // There should be only the first touch.
//    guard newTouch == self.trackedTouch else {
//        self.state = .failed
//        return
//    }
//    // If the stroke was moving up and the final point is
//    // above the initial point, the gesture succeeds.
//    if self.state == .possible &&
//        self.strokePhase == .upStroke &&
//        newPoint.y < initialTouchPoint.y {
//        self.state = .recognized
//    } else {
//        self.state = .failed
//    }
//}
//
//override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
//    super.touchesCancelled(touches, with: event)
//    self.initialTouchPoint = CGPoint.zero
//    self.strokePhase = .notStarted
//    self.trackedTouch = nil
//    self.state = .cancelled
//}
//
//override func reset() {
//    super.reset()
//    self.initialTouchPoint = CGPoint.zero
//    self.strokePhase = .notStarted
//    self.trackedTouch = nil
//}

class Trace: UIView {
    var pointsToDraw:[Int] = [] {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.clear(self.bounds)
        context!.setLineWidth(10.0)
        
        
        if pointsToDraw.count > 4 {
            
            context?.move(to: CGPoint(x: CGFloat(pointsToDraw[0]), y: CGFloat(pointsToDraw[1])))
            
            for i in 2..<pointsToDraw.count {
                if i % 2 == 0 {
                    context?.addLine(to: CGPoint(x: CGFloat(pointsToDraw[i]), y: CGFloat(pointsToDraw[i + 1])))
                }
            }
        }
        
        // Draw
        context!.strokePath();
    }
}
