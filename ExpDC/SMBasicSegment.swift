
import Foundation
import UIKit

open class SMBasicSegment : UIView {
    @objc open internal(set) var index: Int = 0
    @objc open internal(set) weak var segmentView: SMBasicSegmentView?
    
    @objc open fileprivate(set) var isSelected: Bool = false
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: Selections
    @objc internal func setSelected(_ selected: Bool, inView view: SMBasicSegmentView) {
        self.isSelected = selected
    }
    
    open func orientationChangedTo(_ mode: SegmentOrganiseMode){
        
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if self.isSelected == false{
            self.segmentView?.selectSegmentAtIndex(self.index)
        }
    }
}
