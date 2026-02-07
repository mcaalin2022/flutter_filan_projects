
// This class represents the University data model used throughout the application
class UniversityModel {
  String? id; // Unique identifier for the university from the database
  String? name; // Full name of the university
  String? location; // Geographical location (e.g., Mogadishu, Somalia)
  String? tuitionRange; // Estimated range of tuition fees (e.g., $500 - $1200)
  List<String>? faculties; // List of departments or faculties available
  String? contactInfo; // Contact details like email or phone
  String? admissionInfo; // Information about the admission process
  String? feesInfo; // Detailed breakdown of various fees
  String? requirementsInfo; // Academic and documentation requirements
  String? imageUrl; // URL of the university's representative image

  // Standard constructor for initializing a university object
  UniversityModel({
    this.id,
    this.name,
    this.location,
    this.tuitionRange,
    this.faculties,
    this.contactInfo,
    this.admissionInfo,
    this.feesInfo,
    this.requirementsInfo,
    this.imageUrl,
  });

  // Factory method to create a UniversityModel instance from a JSON map
  UniversityModel.fromJson(Map<String, dynamic> json) {
    id = json['_id']; // Map the MongoDB _id field
    name = json['name']; // Map university name
    location = json['location']; // Map location string
    tuitionRange = json['tuitionRange']; // Map tuition range
    // Convert dynamic list to a list of strings if it exists
    faculties = json['faculties'] != null ? List<String>.from(json['faculties']) : null;
    contactInfo = json['contactInfo']; // Map contact info
    admissionInfo = json['admissionInfo']; // Map admission details
    feesInfo = json['feesInfo']; // Map fee details
    requirementsInfo = json['requirementsInfo']; // Map requirements info
    imageUrl = json['imageUrl']; // Map image URL
  }

  // Method to convert the model instance back into a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{}; // Initialize a new map
    data['_id'] = id; // Add ID to map
    data['name'] = name; // Add name to map
    data['location'] = location; // Add location to map
    data['tuitionRange'] = tuitionRange; // Add tuition range to map
    data['faculties'] = faculties; // Add faculties list to map
    data['contactInfo'] = contactInfo; // Add contact info to map
    data['admissionInfo'] = admissionInfo; // Add admission info to map
    data['feesInfo'] = feesInfo; // Add fees info to map
    data['requirementsInfo'] = requirementsInfo; // Add requirements info to map
    data['imageUrl'] = imageUrl; // Add image URL to map
    return data; // Return the completed map
  }
}



