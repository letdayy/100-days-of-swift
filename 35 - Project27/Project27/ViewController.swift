//
//  ViewController.swift
//  Project27
//
//  Created by leticia.dayane on 10/05/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRetangle()
    }
    
    func drawRetangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = img
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
            
        }
        
        imageView.image = img
    }
    
    //challenge 1
    func drawStar() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let points = 5
            let outerRadius = CGFloat(256)
            let innerRadius = outerRadius / 2.5
            
            let angle = CGFloat(2 * Double.pi) / CGFloat(points)
            var theta: CGFloat = -CGFloat(Double.pi / 2)
            var first = true
            
            for _ in 0..<points {
                if first {
                    ctx.cgContext.move(to: CGPoint(x: outerRadius * cos(theta), y: outerRadius * sin(theta)))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: outerRadius * cos(theta), y: outerRadius * sin(theta)))
                }
                
                theta += angle
                
                ctx.cgContext.addLine(to: CGPoint(x: innerRadius * cos(theta), y: innerRadius * sin(theta)))
                
                theta += angle
            }
            
            ctx.cgContext.closePath()
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.fillPath()
        }
        
        imageView.image = img
    }
    
    //challenge 2
    func drawTwin() {
        let imgWidth = 512
        let imgHeight = 512
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imgWidth, height: imgHeight))
        
        let height = 150
        let spacing = 40
        
        let top: Int = (imgHeight - height) / 2
        let bottom = top + height
        
        let width: Int = height * 2 / 3
        
        var startx = (imgWidth - (width + spacing + width + spacing + spacing + width)) / 2
        
        let img = renderer.image { ctx in
            drawT(ctx: ctx.cgContext, top: top, bottom: bottom, startx: startx, width: width)
            
            startx += width + spacing
            drawW(ctx: ctx.cgContext, top: top, bottom: bottom, startx: startx, width: width)
            
            startx += width + spacing
            drawI(ctx: ctx.cgContext, top: top, bottom: bottom, startx: startx, width: width)
            
            startx += spacing
            drawN(ctx: ctx.cgContext, top: top, bottom: bottom, startx: startx, width: width)
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.setLineJoin(.round)
            ctx.cgContext.setLineCap(.round)
            ctx.cgContext.drawPath(using: .stroke)
        }
        
        imageView.image = img
    }
    
    //challenge 2
    func drawT(ctx: CGContext, top: Int, bottom: Int, startx: Int, width: Int) {
        ctx.move(to: CGPoint(x: startx, y: top))
        ctx.addLine(to: CGPoint(x: startx + width, y: top))
        ctx.move(to: CGPoint(x: startx + width / 2, y: top))
        ctx.addLine(to: CGPoint(x: startx + width / 2, y: bottom))
    }
    
    //challenge 2
    func drawW(ctx: CGContext, top: Int, bottom: Int, startx: Int, width: Int) {
        ctx.move(to: CGPoint(x: startx, y: top))
        ctx.addLine(to: CGPoint(x: Double(startx) + Double(width) * 0.3, y: Double(bottom)))
        ctx.addLine(to: CGPoint(x: Double(startx) + Double(width) * 0.5, y: Double(top + bottom) / 2))
        ctx.addLine(to: CGPoint(x: Double(startx) + Double(width) * 0.7, y: Double(bottom)))
        ctx.addLine(to: CGPoint(x: startx + width, y: top))
    }
    
    //challenge 2
    func drawI(ctx: CGContext, top: Int, bottom: Int, startx: Int, width: Int) {
        ctx.move(to: CGPoint(x: startx, y: top))
        ctx.addLine(to: CGPoint(x: startx, y: bottom))
    }
    
    //challenge 2
    func drawN(ctx: CGContext, top: Int, bottom: Int, startx: Int, width: Int) {
        ctx.move(to: CGPoint(x: startx, y: bottom))
        ctx.addLine(to: CGPoint(x: startx, y: top))
        ctx.addLine(to: CGPoint(x: startx + width, y: bottom))
        ctx.addLine(to: CGPoint(x: startx + width, y: top))
    }

    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 7 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRetangle()
            
        case 1:
            drawCircle()
            
        case 2:
            drawCheckerboard()
            
        case 3:
            drawRotatedSquares()
            
        case 4:
            drawLines()
            
        case 5:
            drawImagesAndText()
            
        case 6:
            drawStar()
            
        case 7:
            drawTwin()
            
        default:
            break
        }
    }
    
}

