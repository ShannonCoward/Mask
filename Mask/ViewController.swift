//
//  ViewController.swift
//  Mask
//
//  Created by Shannon Armon on 6/25/15.
//  Copyright (c) 2015 Shannon Armon. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()

     var myImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
        
        myImageView.frame = view.frame
        myImageView.contentMode = UIViewContentMode.ScaleAspectFill
        view.addSubview(myImageView)
        
        var showCamera = UIButton(frame: CGRectMake(0, 0, 100, 100))
        showCamera.center = CGPointMake(UIScreen.mainScreen().bounds.width / 2, UIScreen.mainScreen().bounds.height - 70)
        
        showCamera.backgroundColor = UIColor.lightGrayColor()
        showCamera.layer.cornerRadius = 50
        
        view.addSubview(showCamera)
        
        showCamera.addTarget(self, action: "showImagePicker", forControlEvents: .TouchUpInside)
        
        var newMask = UIButton(frame: CGRectMake(10, 10, 40, 40))
        
        newMask.backgroundColor = UIColor.redColor()
        newMask.layer.cornerRadius = 20
        
        view.addSubview(newMask)
        
        newMask.addTarget(self, action: "addNewMask", forControlEvents: .TouchUpInside)
        
        var pinchGesture = UIPinchGestureRecognizer(target: self, action: "resizeMask:")
        
        view.addGestureRecognizer(pinchGesture)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func resizeMask(gr: UIPinchGestureRecognizer) {
        
        if let currentMask = currentMask {
            
        let width = currentMask.frame.width
        let height = currentMask.frame.height
            
            let scale = 1.0 - ((1.0 - gr.scale) / 2)
            
            currentMask.frame.size.height = height + gr.velocity
            currentMask.frame.size.width = width + gr.velocity
        }
        
    }
    
    var currentMask: UIImageView?
    
    func addNewMask() {
    
        var newMaskView = UIImageView(frame: CGRectMake(0, 0, 200, 200))
        
        newMaskView.image = UIImage(named: "Mask")
        newMaskView.center = view.center
        
        view.addSubview(newMaskView)
        
        currentMask = newMaskView
    
    }
    
    
    func showImagePicker() {
    
        presentViewController(imagePicker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        myImageView.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }

    var startTouchLocation: CGPoint!
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if touches.count > 1 { return } // dont move image if more than one touch
        
        if let touch = touches.first as? UITouch {
            
            let location = touch.locationInView(view)
           
            startTouchLocation = touch.locationInView(view)
    }
}
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        
        if touches.count > 1 { return } // dont move image if more than one touch
        
        if let touch = touches.first as? UITouch {
            
            let location = touch.locationInView(view)
            
            let distance = CGPointMake(location.x - startTouchLocation.x, location.y - startTouchLocation.y)
            
            if let currentMask = currentMask {
            
            currentMask.center = CGPointMake(currentMask.center.x + distance.x, currentMask.center.y + distance.y)
                
            }
            
            startTouchLocation = location
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

