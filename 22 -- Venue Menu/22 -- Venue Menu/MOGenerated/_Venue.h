// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Venue.h instead.

#import <CoreData/CoreData.h>

extern const struct VenueAttributes {
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *icon;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *phoneNumber;
	__unsafe_unretained NSString *postalCode;
	__unsafe_unretained NSString *state;
	__unsafe_unretained NSString *streetAddress;
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

@property (nonatomic, strong) NSString* city;

//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* icon;

//- (BOOL)validateIcon:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* phoneNumber;

@property (atomic) int32_t phoneNumberValue;
- (int32_t)phoneNumberValue;
- (void)setPhoneNumberValue:(int32_t)value_;

//- (BOOL)validatePhoneNumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* postalCode;

@property (atomic) int16_t postalCodeValue;
- (int16_t)postalCodeValue;
- (void)setPostalCodeValue:(int16_t)value_;

//- (BOOL)validatePostalCode:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* state;

//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* streetAddress;

//- (BOOL)validateStreetAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Location *coordinates;

//- (BOOL)validateCoordinates:(id*)value_ error:(NSError**)error_;

@end

@interface _Venue (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;

- (NSString*)primitiveIcon;
- (void)setPrimitiveIcon:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitivePhoneNumber;
- (void)setPrimitivePhoneNumber:(NSNumber*)value;

- (int32_t)primitivePhoneNumberValue;
- (void)setPrimitivePhoneNumberValue:(int32_t)value_;

- (NSNumber*)primitivePostalCode;
- (void)setPrimitivePostalCode:(NSNumber*)value;

- (int16_t)primitivePostalCodeValue;
- (void)setPrimitivePostalCodeValue:(int16_t)value_;

- (NSString*)primitiveState;
- (void)setPrimitiveState:(NSString*)value;

- (NSString*)primitiveStreetAddress;
- (void)setPrimitiveStreetAddress:(NSString*)value;

- (Location*)primitiveCoordinates;
- (void)setPrimitiveCoordinates:(Location*)value;

@end
