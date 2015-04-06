// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Venue.h instead.

#import <CoreData/CoreData.h>

extern const struct VenueAttributes {
	__unsafe_unretained NSString *cityStateZip;
	__unsafe_unretained NSString *icon;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *phoneNumber;
	__unsafe_unretained NSString *rating;
	__unsafe_unretained NSString *streetAddress;
	__unsafe_unretained NSString *venueDescription;
} VenueAttributes;

extern const struct VenueRelationships {
	__unsafe_unretained NSString *coordinates;
} VenueRelationships;

@class Location;

@interface VenueID : NSManagedObjectID {}
@end

@interface _Venue : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) VenueID* objectID;

@property (nonatomic, strong) NSString* cityStateZip;

//- (BOOL)validateCityStateZip:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* icon;

//- (BOOL)validateIcon:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* phoneNumber;

//- (BOOL)validatePhoneNumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* rating;

@property (atomic) int16_t ratingValue;
- (int16_t)ratingValue;
- (void)setRatingValue:(int16_t)value_;

//- (BOOL)validateRating:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* streetAddress;

//- (BOOL)validateStreetAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* venueDescription;

//- (BOOL)validateVenueDescription:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Location *coordinates;

//- (BOOL)validateCoordinates:(id*)value_ error:(NSError**)error_;

@end

@interface _Venue (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCityStateZip;
- (void)setPrimitiveCityStateZip:(NSString*)value;

- (NSString*)primitiveIcon;
- (void)setPrimitiveIcon:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitivePhoneNumber;
- (void)setPrimitivePhoneNumber:(NSString*)value;

- (NSNumber*)primitiveRating;
- (void)setPrimitiveRating:(NSNumber*)value;

- (int16_t)primitiveRatingValue;
- (void)setPrimitiveRatingValue:(int16_t)value_;

- (NSString*)primitiveStreetAddress;
- (void)setPrimitiveStreetAddress:(NSString*)value;

- (NSString*)primitiveVenueDescription;
- (void)setPrimitiveVenueDescription:(NSString*)value;

- (Location*)primitiveCoordinates;
- (void)setPrimitiveCoordinates:(Location*)value;

@end
