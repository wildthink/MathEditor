//
//  MTScrollingMathKeyboardRootView.m
//  Pods
//
//  Created by Serdar Karatekin on 8/2/16.
//
//

#import "MTScrollingMathKeyboardRootView.h"
#import "MTFontManager.h"
#import "MTMathAtomFactory.h"

static NSInteger const DEFAULT_KEYBOARD = 0;
/// Lowest tag of a math key button
static NSInteger const MATH_KEY_TAG_SMALLEST = 100;
/// Lowest tag of a QWERTY key button
static NSInteger const QWERTY_KEY_TAG_SMALLEST = 1000;

@interface MTScrollingMathKeyboardRootView ()

@end

@implementation MTScrollingMathKeyboardRootView {
    
}

// Keyboard should be singleton
+(instancetype)sharedInstance {
    static MTScrollingMathKeyboardRootView *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSBundle* bundle = [self getMathKeyboardResourcesBundle];
        instance = [bundle loadNibNamed:@"MTScrollingMathKeyboardRootView" owner:nil options:nil][0];
        
    });
    
    return instance;
}

// Gets the math keyboard resources bundle
+(NSBundle *)getMathKeyboardResourcesBundle
{
    return [NSBundle bundleWithURL:[[NSBundle bundleForClass:[self class]] URLForResource:@"MTKeyboardResources" withExtension:@"bundle"]];
}

-(void)awakeFromNib
{
    [self styleAllColumns:self.scrollView.subviews];
    
    [self styleAllButtons:self.scrollView.subviews];
    
}

-(void)styleAllColumns:(NSArray<__kindof UIView *> *) columns
{
    for (UIView *columnView in self.scrollView.subviews) {
        columnView.backgroundColor = [UIColor clearColor];
    }
}

-(void)styleAllButtons:(NSArray<__kindof UIView *> *) subviews
{
    for (UIView *subview in subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            [self styleButton:(UIButton *)subview];
        }
        
        [self styleAllButtons:subview.subviews];
    }
}

-(void)styleButton:(UIButton *)button
{
    button.layer.cornerRadius = 5;
    button.imageView.contentMode = UIViewContentModeCenter;
}

#pragma mark - MTMathKeyboardTraits

- (void)setEqualsAllowed:(BOOL)equalsAllowed
{
//    _equalsAllowed = equalsAllowed;
//    for (MTKeyboard *keyboard in _keyboards) {
//        [keyboard setEqualsState:equalsAllowed];
//    }
}

- (void)setNumbersAllowed:(BOOL)numbersAllowed
{
//    _numbersAllowed = numbersAllowed;
//    for (MTKeyboard *keyboard in _keyboards) {
//        [keyboard setNumbersState:numbersAllowed];
//    }
}

- (void)setOperatorsAllowed:(BOOL)operatorsAllowed
{
//    _operatorsAllowed = operatorsAllowed;
//    for (MTKeyboard *keyboard in _keyboards) {
//        [keyboard setOperatorState:operatorsAllowed];
//    }
}

- (void)setVariablesAllowed:(BOOL)variablesAllowed
{
//    _variablesAllowed = variablesAllowed;
//    for (MTKeyboard *keyboard in _keyboards) {
//        [keyboard setVariablesState:variablesAllowed];
//    }
}

- (void)setExponentHighlighted:(BOOL)exponentHighlighted
{
//    _exponentHighlighted = exponentHighlighted;
//    for (MTKeyboard *keyboard in _keyboards) {
//        [keyboard setExponentState:exponentHighlighted];
//    }
}

- (void)setSquareRootHighlighted:(BOOL)squareRootHighlighted
{
//    _squareRootHighlighted = squareRootHighlighted;
//    for (MTKeyboard *keyboard in _keyboards) {
//        [keyboard setSquareRootState:squareRootHighlighted];
//    }
}

- (void)setRadicalHighlighted:(BOOL)radicalHighlighted
{
//    _radicalHighlighted = radicalHighlighted;
//    for (MTKeyboard *keyboard in _keyboards) {
//        [keyboard setRadicalState:radicalHighlighted];
//    }
}

- (void)startedEditing:(UIView<UIKeyInput> *)label
{
    self.textView = label;
}

- (void)finishedEditing:(UIView<UIKeyInput> *)label
{
    self.textView = nil;
}

#pragma mark - IBActions

- (IBAction)keyPressed:(id)sender {
    
    [self playClickForCustomKeyTap];
    
    UIButton *button = sender;
    NSLog(@"keyPressed: tag %tu", button.tag);
    
    if (button.tag >= QWERTY_KEY_TAG_SMALLEST) {
        int buttonTag = button.tag - QWERTY_KEY_TAG_SMALLEST;
        [self handleQWERTYButtonClick:buttonTag];
    } else {
        int buttonTag = button.tag - MATH_KEY_TAG_SMALLEST;
        [self handleButtonClick:buttonTag];
    }
}

- (void)handleButtonClick:(int )tag {
    
    switch (tag) {
        case 0:
            [self.textView insertText:@"7"];
            break;
        case 1:
            [self.textView insertText:@"4"];
            break;
        case 2:
            [self.textView insertText:@"1"];
            break;
        case 3:
            [self.textView insertText:@"0"];
            break;
        case 4:
            [self.textView insertText:@"8"];
            break;
        case 5:
            [self.textView insertText:@"5"];
            break;
        case 6:
            [self.textView insertText:@"2"];
            break;
        case 7:
            [self.textView insertText:@"-"];
            break;
        case 8:
            [self.textView insertText:@"9"];
            break;
        case 9:
            [self.textView insertText:@"6"];
            break;
        case 10:
            [self.textView insertText:@"3"];
            break;
        case 11:
            [self.textView insertText:@"="];
            break;
        case 12:
            [self.textView insertText:MTSymbolDivision];
            break;
        case 13:
            [self.textView insertText:MTSymbolMultiplication];
            break;
        case 14:
            [self.textView insertText:@"+"];
            break;
        case 15:
            [self.textView insertText:@"-"];
            break;
        case 16:
            [self.textView insertText:@"x"];
            break;
        case 17:
            [self.textView insertText:@"y"];
            break;
        case 18:
            [self.textView insertText:MTSymbolFractionSlash];
            break;
        case 19:
            [self.textView insertText:@"."];
            break;
        case 20:
            [self.textView insertText:@"f"];
            [self.textView insertText:@"("];
            [self.textView insertText:@"x"];
            [self.textView insertText:@")"];
            break;
        case 21:
            [self.textView insertText:@"g"];
            [self.textView insertText:@"("];
            [self.textView insertText:@"x"];
            [self.textView insertText:@")"];
            break;
        case 22:
            [self.textView insertText:@"^"];
            break;
        case 23:
            [self.textView insertText:@","];
            break;
        case 24:
            [self.textView insertText:@"^"];
            [self.textView insertText:@"2"];
            // Inserting another exponent should bring the level back down to regular
            [self.textView insertText:@"^"];
            break;
        case 25:
            [self.textView insertText:MTSymbolFractionSlash];
            break;
        case 26:
            [self.textView insertText:MTSymbolSquareRoot];
            break;
        case 27:
            //
            break;
        case 28:
            [self.textView insertText:@"^"];
            break;
        case 29:
            [self.textView insertText:@"||"];
            break;
        case 30:
            [self.textView insertText:MTSymbolCubeRoot];
            break;
        case 31:
            //
            break;
        case 32:
            [self.textView insertText:@"("];
            break;
        case 33:
            [self.textView insertText:@"["];
            break;
        case 34:
            [self.textView insertText:@"{"];
            break;
        case 35:
            //
            break;
        case 36:
            [self.textView insertText:@")"];
            break;
        case 37:
            [self.textView insertText:@"]"];
            break;
        case 38:
            [self.textView insertText:@"}"];
            break;
        case 39:
            //
            break;
        case 40:
            [self.textView insertText:@">"];
            break;
        case 41:
            [self.textView insertText:MTSymbolGreaterEqual];
            break;
        case 42:
            [self.textView insertText:@"="];
            break;
        case 43:
            //
            break;
        case 44:
            [self.textView insertText:@"<"];
            break;
        case 45:
            [self.textView insertText:MTSymbolLessEqual];
            break;
        case 46:
            [self.textView insertText:MTSymbolNotEqual];
            break;
        case 47:
            //
            break;
        case 48:
            [self.textView insertText:@"sin"];
            break;
        case 49:
            [self.textView insertText:@"csc"];
            break;
        case 50:
            [self.textView insertText:@"π"];
            break;
        case 51:
            [self.textView insertText:MTSymbolDegree];
            break;
        case 52:
            [self.textView insertText:@"cos"];
            break;
        case 53:
            [self.textView insertText:@"sec"];
            break;
        case 54:
            [self.textView insertText:@"\u0398"]; // theta
            break;
        case 55:
            [self.textView insertText:MTSymbolAngle];
            break;
        case 56:
            [self.textView insertText:@"tan"];
            break;
        case 57:
            [self.textView insertText:@"cot"];
            break;
        case 58:
            //
            break;
        case 59:
            //
            break;
        case 60:
            [self.textView insertText:@"log"];
            break;
        case 61:
            [self.textView insertText:@"ln"];
            break;
        case 62:
            //
            break;
        case 63:
            //
            break;
        case 64:
            [self.textView insertText:@"log"];
            [self.textView insertText:@"_"];
            break;
        case 65:
            [self.textView insertText:@"e"];
            break;
        case 66:
            //
            break;
        case 67:
            //
            break;
        default:
            NSLog(@"Unsupport button tag click");
            break;
    }
}

- (void) handleQWERTYButtonClick:(int)tag {
    switch (tag) {
        case 0:
            [self.textView insertText:@"q"];
            break;
        case 1:
            [self.textView insertText:@"w"];
            break;
        case 2:
            [self.textView insertText:@"e"];
            break;
        case 3:
            [self.textView insertText:@"r"];
            break;
        case 4:
            [self.textView insertText:@"t"];
            break;
        case 5:
            [self.textView insertText:@"y"];
            break;
        case 6:
            [self.textView insertText:@"u"];
            break;
        case 7:
            [self.textView insertText:@"i"];
            break;
        case 8:
            [self.textView insertText:@"o"];
            break;
        case 9:
            [self.textView insertText:@"p"];
            break;
        case 10:
            [self.textView insertText:@"a"];
            break;
        case 11:
            [self.textView insertText:@"s"];
            break;
        case 12:
            [self.textView insertText:@"d"];
            break;
        case 13:
            [self.textView insertText:@"f"];
            break;
        case 14:
            [self.textView insertText:@"g"];
            break;
        case 15:
            [self.textView insertText:@"h"];
            break;
        case 16:
            [self.textView insertText:@"j"];
            break;
        case 17:
            [self.textView insertText:@"k"];
            break;
        case 18:
            [self.textView insertText:@"l"];
            break;
        case 19:
            [self.textView insertText:@"z"];
            break;
        case 20:
            [self.textView insertText:@"x"];
            break;
        case 21:
            [self.textView insertText:@"c"];
            break;
        case 22:
            [self.textView insertText:@"v"];
            break;
        case 23:
            [self.textView insertText:@"b"];
            break;
        case 24:
            [self.textView insertText:@"n"];
            break;
        case 25:
            [self.textView insertText:@"m"];
            break;
        case 26:
            [self.textView insertText:@" "];
            break;
        case 27:
            [self.textView insertText:@"\n"];
            break;
        default:
            break;
    }
}

#pragma mark - Helpers

- (void) playClickForCustomKeyTap
{
    [[UIDevice currentDevice] playInputClick];
}

@end


