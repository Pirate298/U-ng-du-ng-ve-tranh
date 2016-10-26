//
//  ViewController.swift
//  Ứng dụng vẽ tranh
//
//  Created by PIRATE on 10/25/16.
//  Copyright © 2016 PIRATE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var loaibut = false
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity : CGFloat = 1.0
    var swipe = false
    var pixel: Int = 5
    var baseImage = UIImage()
    let imgColors = ["Black", "Grey", "Red", "Blue", "LightBlue", "DarkGreen", "LightGreen", "Brown", "DarkOrange", "Yellow"]
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
        ]
    
    
    @IBAction func reset(_ sender: AnyObject) {
        mainView.image = baseImage
    }
    
    @IBAction func Album(_ sender: AnyObject) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imgPicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func doiloaibut(_ sender: AnyObject) {
        if loaibut == true
        {
            loaibut = false
            print("true")
        }
         else if loaibut == false
        {
            loaibut = true
            print("false")
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickImage: UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage
        {
            baseImage = pickImage
            mainView.image = baseImage
        }
    }
    
    @IBAction func save(_ sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(mainView.image!, self, nil, nil)
    }
    
    @IBAction func btnClick(_ sender: AnyObject) {
        let index = sender.tag
        switch (index!)
        {
        case 0: pixel = 5
        case 1: pixel = 10
        case 2: pixel = 30
        case 4:(red, green, blue) = colors[10]
        default: break
        }
        
    }
    @IBOutlet weak var mainView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swipe = false
        if let touches = touches.first
        {
            lastPoint = touches.location(in: view)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swipe = true
        if let touch = touches.first
        {
            if loaibut == true
            {
            let currentPoint = touch.location(in: mainView)
             drawLineFome(fromePoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
            }
            if loaibut == false
            {
                let currentPoint = touch.location(in: mainView)
                drawSquare(fromePoint: lastPoint, toPoint: currentPoint)
                lastPoint = currentPoint
            }
            print(loaibut)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swipe {
            // draw a single point
            if loaibut == true {
            drawLineFome(fromePoint: lastPoint, toPoint: lastPoint)
            }
            if loaibut == false {
                 drawSquare(fromePoint: lastPoint, toPoint: lastPoint)
            }
        }
    }
    func drawSquare( fromePoint: CGPoint , toPoint: CGPoint)
    {
        UIGraphicsBeginImageContext(mainView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        mainView.image?.draw(in: CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: mainView.frame.size.height))
        
        context?.move(to: CGPoint(x: fromePoint.x , y: fromePoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(CGFloat(pixel))
        context?.setStrokeColor(red: red , green: green , blue: blue, alpha : 1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        context?.strokePath()
        
        mainView.image = UIGraphicsGetImageFromCurrentImageContext()
        mainView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    

    
    
    func drawLineFome( fromePoint: CGPoint , toPoint: CGPoint)
    {
      UIGraphicsBeginImageContext(mainView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        mainView.image?.draw(in: CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: mainView.frame.size.height))
        
        context?.move(to: CGPoint(x: fromePoint.x , y: fromePoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setLineCap(CGLineCap.square)
        context?.setLineWidth(CGFloat(pixel))
        context?.setStrokeColor(red: red , green: green , blue: blue, alpha : 1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        context?.strokePath()
        
        mainView.image = UIGraphicsGetImageFromCurrentImageContext()
        mainView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellColection", for: indexPath) as! PhotoEffectColectionCell
        cell.filteredImageView.image = UIImage(named: imgColors[(indexPath as NSIndexPath).item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (red, green , blue) = colors[(indexPath as NSIndexPath).item]
    }

}

