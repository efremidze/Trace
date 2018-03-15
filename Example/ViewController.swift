//
//  ViewController.swift
//  Example
//
//  Created by Lasha Efremidze on 2/16/18.
//  Copyright © 2018 Lasha Efremidze. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class ViewController: UIViewController {
    
    @IBOutlet var drawView: DrawView! {
        didSet {
            drawView.backgroundColor = .clear
        }
    }
    
    var gesture: CheckmarkGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gesture = CheckmarkGestureRecognizer(target: self, action: #selector(handleGesture))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handleGesture(_ r: CheckmarkGestureRecognizer) {
//        if r.state == .ended {
//            findCircledView(c.fitResult.center)
//        }
//        print(r.state.rawValue)
        drawView.points = r.samples.map { $0.location }
        switch r.state {
        case .began:
            break
        default:
            break
        }
    }
    
}

enum CheckmarkPhases {
    case notStarted
    case initialPoint
    case downStroke
    case upStroke
}

struct StrokeSample {
    let location: CGPoint
}

class CheckmarkGestureRecognizer: UIGestureRecognizer {
//    var strokePhase: CheckmarkPhases = .notStarted
//    var initialTouchPoint: CGPoint = .zero
//    var touchedPoints = [CGPoint]()
//    var path = CGMutablePath()
    
    var trackedTouch: UITouch?
    var samples = [StrokeSample]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if touches.count != 1 {
            self.state = .failed
        }
        
        // Capture the first touch and store some information about it.
        if self.trackedTouch == nil {
            if let firstTouch = touches.first {
                self.trackedTouch = firstTouch
                self.addSample(for: firstTouch)
                state = .began
            }
        } else {
            // Ignore all but the first touch.
            for touch in touches {
                if touch != self.trackedTouch {
                    self.ignore(touch, for: event)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addSample(for: touches.first!)
        state = .changed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addSample(for: touches.first!)
        state = .ended
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.samples.removeAll()
        state = .cancelled
    }
    
    override func reset() {
        self.samples.removeAll()
        self.trackedTouch = nil
    }
    
    func addSample(for touch: UITouch) {
        let newSample = StrokeSample(location: touch.location(in: self.view))
        self.samples.append(newSample)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
//        super.touchesBegan(touches, with: event)
//
//        print(self.strokePhase)
//
//        if touches.count != 1 {
//            self.state = .failed
//        }
//        self.state = .began
//
//        // Capture the first touch and store some information about it.
//        if self.trackedTouch == nil {
//            self.trackedTouch = touches.first
//            self.strokePhase = .initialPoint
//            self.initialTouchPoint = (self.trackedTouch?.location(in: self.view))!
//
//            let point = trackedTouch!.location(in: self.view)
//            touchedPoints.append(point)
//            path.move(to: point)
//        } else {
//            // Ignore all but the first touch.
//            for touch in touches {
//                if touch != self.trackedTouch {
//                    self.ignore(touch, for: event)
//                }
//            }
//        }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
//        super.touchesMoved(touches, with: event)
//
//        print(self.strokePhase)
//
//        let newTouch = touches.first
//        // There should be only the first touch.
//        guard newTouch == self.trackedTouch else {
//            self.state = .failed
//            return
//        }
//        let newPoint = (newTouch?.location(in: self.view))!
//        let previousPoint = (newTouch?.previousLocation(in: self.view))!
//
//        if self.strokePhase == .initialPoint {
//            // Make sure the initial movement is down and to the right.
//            if newPoint.x >= initialTouchPoint.x && newPoint.y >= initialTouchPoint.y {
//                self.strokePhase = .downStroke
//
//                touchedPoints.append(newPoint)
//                path.addLine(to: newPoint)
//                self.state = .changed
//            } else {
//                self.state = .failed
//            }
//        } else if self.strokePhase == .downStroke {
//            // Always keep moving left to right.
//            if newPoint.x >= previousPoint.x {
//                // If the y direction changes, the gesture is moving up again.
//                // Otherwise, the down stroke continues.
//                if newPoint.y < previousPoint.y {
//                    self.strokePhase = .upStroke
//
//                    touchedPoints.append(newPoint)
//                    path.addLine(to: newPoint)
//                    self.state = .changed
//                }
//            } else {
//                // If the new x value is to the left, the gesture fails.
//                self.state = .failed
//            }
//        } else if self.strokePhase == .upStroke {
//            // If the new x value is to the left, or the new y value
//            // changed directions again, the gesture fails.]
//            if newPoint.x < previousPoint.x || newPoint.y > previousPoint.y {
//                self.state = .failed
//            } else {
//                touchedPoints.append(newPoint)
//                path.addLine(to: newPoint)
//                self.state = .changed
//            }
//        }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
//        super.touchesEnded(touches, with: event)
//
//        print(self.strokePhase)
//        print(self.state.rawValue)
//
//        let newTouch = touches.first
//        let newPoint = (newTouch?.location(in: self.view))!
//        // There should be only the first touch.
//        guard newTouch == self.trackedTouch else {
//            self.state = .failed
//            return
//        }
//
//        // If the stroke was moving up and the final point is
//        // above the initial point, the gesture succeeds.
//        if self.state == .possible &&
//            self.strokePhase == .upStroke &&
//            newPoint.y < initialTouchPoint.y {
//            self.state = .recognized
//
//            touchedPoints.append(newPoint)
//            path.addLine(to: newPoint)
//            self.state = .ended
//        } else {
//            self.state = .failed
//        }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
//        super.touchesCancelled(touches, with: event)
//
//        print(self.strokePhase)
//
//        self.initialTouchPoint = CGPoint.zero
//        self.strokePhase = .notStarted
//        self.trackedTouch = nil
//        self.touchedPoints = []
//        self.path = CGMutablePath()
//        self.state = .cancelled
//    }
//
//    override func reset() {
//        super.reset()
//        self.initialTouchPoint = CGPoint.zero
//        self.strokePhase = .notStarted
//        self.trackedTouch = nil
//        self.touchedPoints = []
//        self.path = CGMutablePath()
//    }
}

// https://code.tutsplus.com/tutorials/smooth-freehand-drawing-on-ios--mobile-13164
// https://github.com/Nicejinux/NXDrawKit/blob/master/NXDrawKit/Classes/Canvas.swift
// https://github.com/IFTTT/jot/blob/master/jot/JotDrawView.m
class DrawView: UIView {
    var points = [CGPoint]() {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
//        for point in points {
//            if points.isEmpty {
//                context.move(to: point)
//            } else {
//                context.addLine(to: point)
//            }
//        }
        4
        var temp = [CGPoint]()
        for point in points {
            if temp.isEmpty {
                context.move(to: point)
            }
            temp.append(point)
            if temp.count == 4 {
                context.addCurve(to: temp[3], control1: temp[1], control2: temp[2])
                temp = [point]
            } else if point == points.last {
                for point in temp {
                    context.addLine(to: point)
                }
            }
        }
        context.setStrokeColor(UIColor.green.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.strokePath()
    }
}
