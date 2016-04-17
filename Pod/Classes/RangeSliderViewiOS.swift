//
//  RangeSliderViewiOS.swift
//  Pods
//
//  Created by Omar Abdelhafith on 07/02/2016.
//
//

#if os(iOS)
  import UIKit
  
  /// Range slider view
  @IBDesignable
  public class RangeSliderView: UIControl, RangeSlider {
    
    
    /// Minimum slider selectable value
    /// Defaults to 0
    @IBInspectable public var minimumValue: Int = 0 {
      didSet {
        fullRange = minimumValue..<maximumValue
      }
    }
    
    /// Maximum slider selectable value
    /// Defaults to 100
    @IBInspectable public var maximumValue: Int = 100 {
      didSet {
        fullRange = minimumValue..<maximumValue
      }
    }
    
    /// Set/Get the slider minimum selected value
    /// Defaults to 0
    @IBInspectable public var minimumSelectedValue: Int {
      get {
        return selectedRange.startIndex
      }
      
      set {
        selectedRange = (newValue..<maximumSelectedValue)
        updateKnobsPlacements()
      }
    }
    
    
    /// Set/Get the slider maximum selected value
    /// Defaults to 100
    @IBInspectable public var maximumSelectedValue: Int {
      get {
        return selectedRange.endIndex
      }
      
      set {
        selectedRange = (minimumSelectedValue..<newValue)
        updateKnobsPlacements()
      }
    }
    
    
    /// Callback called when minimum and maximum slider knobs are moved
    public var selectedValuesChanged: ((Int, Int) -> ())?
    
    // Mark: - Private
    
    var backgroundView: SliderBackground = SliderBackgroundView()
    public var minimumKnobView: SliderKnob = SliderKnobView()
    public var maximumKnobView: SliderKnob = SliderKnobView()
    
    var fullRange: Range<Int> = 0..<100 {
      didSet {
        updateKnobsPlacements()
      }
    }
    
    var selectedRange: Range<Int> =  0..<100
    
    public override init(frame: CGRect) {
      super.init(frame: frame)
      addViewsAndRegisterCallbacks()
    }
    
    required public init?(coder: NSCoder) {
      super.init(coder: coder)
      addViewsAndRegisterCallbacks()
    }
    
    public override var bounds: CGRect {
      didSet {
        backgroundView.view.frame = bounds
        minimumKnobView.view.frame = bounds
        minimumKnobView.view.frame = bounds
        updateKnobsPlacements()
        setNeedsDisplay()
      }
    }
    
    func informAboutValueChanged() {
      sendActionsForControlEvents(.ValueChanged)
    }
    
  }
  
  
  /// Color costumization extension
  public extension RangeSliderView {
    
    /// The knob background color
    @IBInspectable public var sliderKnobColor: UIColor {
      get {
        return minimumKnobView.knobView.backgroundNormalColor
      }
      set {
        minimumKnobView.knobView.backgroundNormalColor = newValue
        maximumKnobView.knobView.backgroundNormalColor = newValue
      }
    }
    
    /// The knob background color when highlighted
    @IBInspectable public var sliderKnobHighligtedColor: UIColor {
      get {
        return minimumKnobView.knobView.backgroundHighligtedColor
      }
      set {
        minimumKnobView.knobView.backgroundHighligtedColor = newValue
        maximumKnobView.knobView.backgroundHighligtedColor = newValue
      }
    }
    
    /// The knob border color
    @IBInspectable public var sliderKnobBorderColor: UIColor {
      get {
        return minimumKnobView.knobView.borderColor
      }
      set {
        minimumKnobView.knobView.borderColor = newValue
        maximumKnobView.knobView.borderColor = newValue
      }
    }
    
    /// Slider background progress full color
    @IBInspectable public var sliderProgressFilledColor: UIColor {
      get {
        return backgroundView.view.fullColor
      }
      set {
        backgroundView.view.fullColor = newValue
      }
    }
    
    /// Slider background progress empty color
    @IBInspectable public var sliderProgressEmptyColor: UIColor {
      get {
        return backgroundView.view.emptyColor
      }
      set {
        backgroundView.view.emptyColor = newValue
      }
    }
    
  }
#endif
