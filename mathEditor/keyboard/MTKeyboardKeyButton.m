//
//  MTKeyboardKeyButton.m
//  Pods
//
//  Created by Jakub Dolecki on 8/8/16.
//
//

#import "MTKeyboardKeyButton.h"

@implementation MTKeyboardKeyButton {
    UIColor *_originalBackgroundColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit {
    self.layer.cornerRadius = 5.f;
    self.imageView.contentMode = UIViewContentModeCenter;
}

- (void) didMoveToSuperview {
    [super didMoveToSuperview];
    
    _originalBackgroundColor = self.backgroundColor;
}


/** Overwrites UIButton's setHighlighted to add a highlight color when user highlights the button
 */
- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (self.selected == YES) {
        return;
    }
    // Grayish color for when button is highlighted
    UIColor *kMTKeyboardKeyButtonHighlightedColor = [UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.f];
    UIColor *kMTKeyboardKeyButtonDefaultColor = _originalBackgroundColor;
    
    if (highlighted == YES) {
        [self setBackgroundColor:kMTKeyboardKeyButtonHighlightedColor];
    } else {
        [self setBackgroundColor:kMTKeyboardKeyButtonDefaultColor];
    }
}

- (void) setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    UIColor *kMTKeyboardKeyButtonSelectedColor = [UIColor colorWithRed:0.855 green:0.929 blue:1.f alpha:1.f];
    UIColor *kMTKeyboardKeyButtonSelectedBorderColor = [UIColor colorWithRed:0.0745 green:0.482 blue:0.984 alpha:1];
    UIColor *kMTKeyboardKeyButtonDefaultColor = _originalBackgroundColor;
    
    if (selected == YES) {
        [self setBackgroundColor:kMTKeyboardKeyButtonSelectedColor];
        [self.layer setBorderColor:[kMTKeyboardKeyButtonSelectedBorderColor CGColor]];
        [self.layer setBorderWidth:2.f];
    } else {
        [self setBackgroundColor:kMTKeyboardKeyButtonDefaultColor];
        [self.layer setBorderColor:[kMTKeyboardKeyButtonDefaultColor CGColor]];
        [self.layer setBorderWidth:0.f];
    }
}

@end

@implementation MTQwertyKeyboardKeyButton

@end
