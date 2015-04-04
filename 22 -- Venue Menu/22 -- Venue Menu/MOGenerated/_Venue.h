// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Venue.h instead.

#import <CoreData/CoreData.h>

extern const struct VenueAttributes {
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *postalCode;
	__unsafe_unretained NSString *state;
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

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* postalCode;

@property (atomic) int16_t postalCodeValue;
- (int16_t)postalCodeValue;
- (void)setPostalCodeValue:(int16_t)value_;

//- (BOOL)validatePostalCode:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* state;

//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Location *coordinates;

//- (BOOL)validateCoordinates:(id*)value_ error:(NSError**)error_;

@end

@interface _Venue (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitivePostalCode;
- (void)setPrimitivePostalCode:(NSNumber*)value;

- (int16_t)primitivePostalCodeValue;
- (void)setPrimitivePostalCodeValue:(int16_t)value_;

- (NSString*)primitiveState;
- (void)setPrimitiveState:(NSString*)value;

- (Location*)primitiveCoordinates;
- (void)setPrimitiveCoordinates:(Location*)value;

@end
