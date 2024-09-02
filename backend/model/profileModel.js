const mongoose = require('mongoose');

const profileSchema = new mongoose.Schema({
    firstName: { type: String, required: true },
    lastName: { type: String, required: true },
    course: { type: String, required: true },
    year: { type: String, required: true },
    enrolled: { type: Boolean, require: false }
});

const Profile = mongoose.model("Profile", profileSchema);

module.exports = Profile;