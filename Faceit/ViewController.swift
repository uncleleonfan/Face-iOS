//
//  ViewController.swift
//  Faceit
//
//  Created by Leon Fan on 2018/11/5.
//  Copyright © 2018 Leon Fan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            let tapHandler = #selector(toggleEyes(byReactingTo:))
            let tapRecognizer = UITapGestureRecognizer(target: self, action: tapHandler)
            faceView.addGestureRecognizer(tapRecognizer)
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            updateUI()
        }
    }
    
    @objc
    func toggleEyes(byReactingTo tabRecognizer: UITapGestureRecognizer) {
        if tabRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            let mouth: FacialExpression.Mouth = (expression.mouth == .smile) ? .frown : .smile
            expression = FacialExpression(eyes: eyes, mouth: mouth)
        }
    }
    
    var expression: FacialExpression = FacialExpression(eyes: FacialExpression.Eyes.closed, mouth: FacialExpression.Mouth.frown){
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        print("updateUI")
        switch expression.eyes {
        case .open:
            faceView?.eyeOpen = true
            break
        case .closed:
            faceView?.eyeOpen = false
            break
        case .squinting:
            faceView?.eyeOpen = false
            break
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.grin: 0.5, .frown: -1, .smile: 1, .neutral:0.0, .smirk: -0.5]
    
    @objc
    func increaseHappiness() {
        expression = expression.happier
    }
    
    @objc
    func decreaseHappiness() {
        expression = expression.sadder
    }
}

