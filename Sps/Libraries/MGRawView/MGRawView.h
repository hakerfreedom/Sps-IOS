

#import <UIKit/UIKit.h>
//#import "MGTopLeftLabel.h"
//#import "RateView.h"
//#import "MGMapView.h"
//#import "NMRangeSlider.h"
#import "MGTextField.h"
#import "MGButton.h"

@class MGRawView;

@protocol MGRawViewDelegate <NSObject>

-(void) MGRawView:(MGRawView*)view didPressedAnyButton:(UIButton*)button;

@end

@interface MGRawView : UIView <UITextFieldDelegate> {
    
    __weak id <MGRawViewDelegate> _delegate;
    id _object;
}
@property (nonatomic, retain) id object;

@property (nonatomic, retain) IBOutlet UILabel* labelTitle;
@property (nonatomic, retain) IBOutlet UILabel* labelSubtitle;
@property (nonatomic, retain) IBOutlet UILabel* labelDescription;
@property (nonatomic, retain) IBOutlet UILabel* labelInfo;
@property (nonatomic, retain) IBOutlet UILabel* labelDetails;
@property (nonatomic, retain) IBOutlet UILabel* labelExtraInfo;

@property (nonatomic, retain) IBOutlet MGButton* buttonGo;
@property (nonatomic, retain) IBOutlet UIButton* buttonGoStore;

@property (nonatomic, weak) __weak id <MGRawViewDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIButton* buttonCustom;
@property (nonatomic, retain) IBOutlet UITextField* textFieldCustom;
@property (nonatomic, retain) UITextField* activeTextField;
@property (nonatomic, retain) IBOutlet UIImageView* imgViewThumb;
@property (nonatomic, retain) IBOutlet UISegmentedControl* segmentAnimation;


//@property (nonatomic, retain) IBOutlet MGTopLeftLabel* topLeftLabelAddress;
//@property (nonatomic, retain) IBOutlet MGTopLeftLabel* topLeftLabelDescription;


@property (nonatomic, retain) IBOutlet UILabel* label1;
@property (nonatomic, retain) IBOutlet UILabel* label2;
@property (nonatomic, retain) IBOutlet UILabel* label3;
@property (nonatomic, retain) IBOutlet UILabel* label4;
@property (nonatomic, retain) IBOutlet UILabel* label5;


@property (nonatomic, retain) IBOutlet UIButton* buttonEmail;

@property (nonatomic, retain) IBOutlet UIButton* buttonFave;


@property (nonatomic, retain) IBOutlet UILabel* labelPhotos;

@property (nonatomic, retain) IBOutlet UIButton* buttonStarred;


@property (nonatomic, retain) IBOutlet UIButton* buttonNext;
@property (nonatomic, retain) IBOutlet UIButton* buttonPhotos;


@property (nonatomic, retain) IBOutlet UIImageView* imgViewPhoto;


-(id)initWithNibName:(NSString*)nibNameOrNil;

- (id)initWithFrame:(CGRect)frame nibName:(NSString*)nibNameOrNil;

@end