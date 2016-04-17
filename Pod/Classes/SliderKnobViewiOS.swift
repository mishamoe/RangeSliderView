//
//  SliderKnobViewiOS.swift
//  Pods
//
//  Created by Omar Abdelhafith on 07/02/2016.
//
//

#if os(iOS)
  import UIKit
  
  public class SliderKnobView: UIView {
    
    public var boundRange: BoundRange = BoundRange.emptyRange {
      didSet {
        setNeedsDisplay()
      }
    }
    
    public var knobFrame: CGRect {
      get {
        return knobView.frame
      }
      
      set {
        knobView.frame = SliderKnobViewImpl.adjustKnobFrame(newValue, viewFrame: self.frame, boundRange: boundRange)
      }
    }
    
    public var knobView: KnobView!
    
    public var knobMovementCallback : (CGRect -> ())?
    public var knobMovementFinishedCallback : (() -> ())?
    
    init() {
      super.init(frame: CGRectZero)
      commonInit()
    }
    
    required public init?(coder: NSCoder) {
      super.init(coder: coder)
      commonInit()
    }
    
    func commonInit() {
      knobView = KnobView()
      knobView.frame = CGRectMake(0, 0, 30, 30)
      
      self.addSubview(knobView)
    }
    
    
    override public func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
      let isIn = CGRectContainsPoint(knobView.frame, point)
      return isIn ? knobView : nil
    }
    
    var draggingPoint: CGFloat = 0
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
      let pointInKnob = touches.first!.locationInView(knobView)
      draggingPoint = RectUtil.pointHorizontalDistanceFromCenter(forRect: knobFrame, point: pointInKnob)
    }
    
    override public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
      let point = touches.first!.locationInView(self)
      
      knobFrame =
        knobFrame
        |> RectUtil.updateRectHorizontalCenter(xCenter: point.x)
        |> RectUtil.moveRect(toLeft: draggingPoint)
      
      knobMovementCallback?(knobView.frame)
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        knobMovementFinishedCallback?()
    }
    
  }
  
  extension SliderKnobView: SliderKnob {
    public var view: SliderKnobView { return self }
  }
#endif
