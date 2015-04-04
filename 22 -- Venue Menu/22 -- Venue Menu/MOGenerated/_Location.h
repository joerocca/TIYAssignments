// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Location.h instead.

#import <CoreData/CoreData.h>

extern const struct LocationAttributes {
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *streetAddress;
} LocationAttributes;

extern const struct LocationRelationships {
	__unsafe_unretained NSString *venue;
} LocationRelationships;

@class Venue;

@interface LocationID : NSManagedObjectID {}
@end

@interface _Location : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LocationID* objectID;

@property (nonatomic, strong) NSNumber* latitude;

@property (atomic) double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* longitude;

@property (atomic) double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* streetAddress;

//- (BOOL)validateStreetAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *venue;

- (NSMutableSet*)venueSet;

@end

@interface _Location (VenueCoreDataGeneratedAccessors)
- (void)addVenue:(NSSet*)value_;
- (void)removeVenue:(NSSet*)value_;
- (void)addVenueObject:(Venue*)value_;
- (void)removeVenueObject:(Venue*)value_;

@end

@interface _Location (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;

- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;

- (NSString*)primitiveStreetAddress;
- (void)setPrimitiveStreetAddress:(NSString*)value;

- (NSMutableSet*)primitiveVenue;
- (void)setPrimitiveVenue:(NSMutableSet*)value;

@end
