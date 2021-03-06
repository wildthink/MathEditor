//
//  EditableMathUILabel.h
//
//  Created by Kostub Deshmukh on 9/2/13.
//  Copyright (C) 2013 MathChat
//   
//  This software may be modified and distributed under the terms of the
//  MIT license. See the LICENSE file for details.
//

#import <UIKit/UIKit.h>
#import <iosMath/MTMathList.h>
#import <iosMath/MTMathUILabel.h>

@class MTEditableMathLabel;
@class MTMathListIndex;

/** Delegate for the `MTEditableMathLabel`. All methods are optional. */
@protocol MTEditableMathLabelDelegate <NSObject>

@optional

// Called when the return key is pressed
- (void) returnPressed:(MTEditableMathLabel*) label;
// called when any text is modified
- (void) textModified:(MTEditableMathLabel*) label;

- (void) didBeginEditing:(MTEditableMathLabel*) label;
- (void) didEndEditing:(MTEditableMathLabel*) label;

@end

/** This protocol provides information on the context of the current insertion point. 
 The keyboard may choose to enable/disable/highlight certain parts of the UI depending on the context.
 e.g. you cannot enter the = sign when you are in a fraction so the keyboard could disable that.
 */
@protocol MTMathKeyboardTraits <NSObject>

@property (nonatomic) BOOL equalsAllowed;
@property (nonatomic) BOOL fractionsAllowed;
@property (nonatomic) BOOL variablesAllowed;
@property (nonatomic) BOOL numbersAllowed;
@property (nonatomic) BOOL operatorsAllowed;
@property (nonatomic) BOOL exponentHighlighted;
@property (nonatomic) BOOL squareRootHighlighted;
@property (nonatomic) BOOL radicalHighlighted;

@end

/** Any keyboard that provides input to the `MTEditableMathUILabel` must implement
 this protocol.
 
 This protocol informs the keyboard when a particular `MTEditableMathUILabel` is being edited.
 The keyboard should use this information to send `UIKeyInput` messages to the label.
 
 This protocol inherits from `MTMathKeyboardTraits`.
 */
@protocol MTMathKeyboard <MTMathKeyboardTraits>

- (void) startedEditing:(UIView<UIKeyInput>*) label;
- (void) finishedEditing:(UIView<UIKeyInput>*) label;

@end

/** 
 */
@protocol MTMathAccessoryView

@end


@interface MTEditableMathLabel : UIView<UIKeyInput>

@property (nonatomic) MTMathList* mathList;
@property (nonatomic) UIColor* highlightColor;
@property (nonatomic) UIColor* textColor;
@property (nonatomic) UIColor* placeholderColor;
@property (nonatomic) MTTextAlignment textAlignment;

@property (nonatomic) UIImageView* cancelImage;
@property (nonatomic, weak) id<MTEditableMathLabelDelegate> delegate;
@property (nonatomic) UIView<MTMathAccessoryView>* accessoryView;
@property (nonatomic, weak) UIView<MTMathKeyboard>* keyboard;
@property (nonatomic) UILabel* errorLabel;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat paddingBottom;
@property (nonatomic) CGFloat paddingTop;
@property (nonatomic) UIColor* caretColor;

- (void) clear;

- (void) highlightCharacterAtIndex:(MTMathListIndex*) index;
- (void) clearHighlights;
- (void) moveCaretToPoint:(CGPoint) point;
- (void) startEditing;
- (void) enableTap:(BOOL) enable;

// Insert a list at a given point.
- (void) insertMathList:(MTMathList*) list atPoint:(CGPoint) point;

- (CGSize) mathDisplaySize;

// Modify provided `mathList` by removing all placeholders.
+ (MTMathList *) mathListWithRemovedPlaceholders:(MTMathList *)mathList;
// Determine if math list has a placeholder. 
+ (BOOL) hasPlaceholders:(MTMathList *)mathList;

// Error display
@property (nonatomic) BOOL autoHidesError;
@property (nonatomic) NSTimeInterval timeToHideError;
- (void) displayError:(NSString*) errorMessage animationDuration:(NSTimeInterval)duration;
- (void) hideError:(NSTimeInterval)duration;

@end
