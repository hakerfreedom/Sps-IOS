

#import "MGListCell.h"

@implementation MGListCell

//@synthesize sli;

@synthesize labelTitle;
@synthesize labelSubtitle;


@synthesize labelDescription;
@synthesize labelInfo;
@synthesize labelDetails;
@synthesize labelExtraInfo;
@synthesize imgViewThumb;
@synthesize imgViewBg;
@synthesize imgViewPic;


@synthesize selectedImage;
@synthesize unselectedImage;
@synthesize imgViewSelectionBackground;

@synthesize selectedColor;
@synthesize unSelectedColor;
@synthesize imgViewArrow;

@synthesize selectedImageArrow;
@synthesize unselectedImageArrow;

@synthesize selectedImageIcon;
@synthesize unselectedImageIcon;

@synthesize imgViewIcon;

@synthesize object;


@synthesize labelStatus;
@synthesize labelDateAdded;
@synthesize labelAddress;
@synthesize labelDesc;

@synthesize labelDateAddedVal;
@synthesize labelHeader1;
@synthesize labelHeader2;
@synthesize labelHeader3;
@synthesize labelHeader4;
@synthesize imgViewFave;
@synthesize labelDistance;

@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;
@synthesize buttonDirections;

@synthesize lblNonSelectorTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // Configure the view for the selected state
    
    
    [super setSelected:selected animated:animated];
    
    if(selected) {
        imgViewSelectionBackground.image = selectedImage;
        labelTitle.textColor = selectedColor;
    }
    else {
        imgViewSelectionBackground.image = unselectedImage;
        labelTitle.textColor = unSelectedColor;
    }
}

@end
